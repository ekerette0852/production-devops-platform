module "networking" {
  source = "../../modules/networking"

  project_name       = "${var.project_name}-${var.environment}"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}

module "security" {
  source = "../../modules/security"

  project_name = var.project_name
  environment  = var.environment
  vpc_id       = module.networking.vpc_id
}

module "compute" {
  source = "../../modules/compute"

  project_name       = var.project_name
  environment        = var.environment
  subnet_id          = module.networking.private_subnets[0]
  security_group_ids = [module.security.security_group_id]
  instance_type      = "t3.micro"

  create_instance = false
}

module "alb" {
  source = "../../modules/alb"

  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.networking.vpc_id
  public_subnet_ids  = module.networking.public_subnets
  target_instance_id = null
  target_port        = 80
}

resource "aws_vpc_security_group_ingress_rule" "app_http_from_alb" {
  description = "Allow HTTP traffic from the Application Load Balancer"

  security_group_id            = module.security.security_group_id
  referenced_security_group_id = module.alb.alb_security_group_id

  from_port   = 80
  to_port     = 80
  ip_protocol = "tcp"
}

module "launch_template" {
  source = "../../modules/launch-template"

  project_name = var.project_name
  environment  = var.environment

  ami_id        = module.compute.ami_id
  instance_type = var.instance_type

  security_group_id     = module.security.security_group_id
  instance_profile_name = module.compute.instance_profile_name

  user_data = file("../../modules/compute/user-data.sh")
}

module "autoscaling" {
  source = "../../modules/autoscaling"

  project_name = var.project_name
  environment  = var.environment

  launch_template_id = module.launch_template.launch_template_id

  private_subnet_ids = module.networking.private_subnets
  target_group_arn   = module.alb.target_group_arn

  desired_capacity = 2
  min_size         = 2
  max_size         = 4
}

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
}

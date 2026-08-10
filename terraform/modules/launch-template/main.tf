resource "aws_launch_template" "this" {
  name_prefix   = "${var.project_name}-${var.environment}-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile {
    name = var.instance_profile_name
  }

  user_data = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name        = "${var.project_name}-${var.environment}"
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

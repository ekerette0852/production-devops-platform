output "vpc_id" {
  description = "ID of the development VPC."
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets."
  value       = module.networking.public_subnets
}

output "private_subnet_ids" {
  description = "IDs of the private subnets."
  value       = module.networking.private_subnets
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway."
  value       = module.networking.nat_gateway_id
}

output "security_group_id" {
  value = module.security.security_group_id
}

output "instance_id" {
  description = "ID of the application EC2 instance."
  value       = module.compute.instance_id
}

output "instance_private_ip" {
  description = "Private IP address of the application EC2 instance."
  value       = module.compute.private_ip
}

output "compute_iam_role_name" {
  description = "IAM role assigned to the EC2 instance."
  value       = module.compute.iam_role_name
}

output "compute_ami_id" {
  description = "Amazon Linux 2023 AMI selected for the instance."
  value       = module.compute.ami_id
}

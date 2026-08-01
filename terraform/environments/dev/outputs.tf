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

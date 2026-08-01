variable "aws_region" {
  type        = string
  description = "AWS region where resources will be created."
}

variable "project_name" {
  type        = string
  description = "Project name used for resource naming."
}

variable "environment" {
  type        = string
  description = "Deployment environment."
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for public subnets."
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDR blocks for private subnets."
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones used by the networking module."
}

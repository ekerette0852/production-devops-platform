variable "project_name" {
  type        = string
  description = "Name of the project used for resource naming."
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
  description = "Availability zones for subnet placement."
}

variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "subnet_id" {
  description = "Private subnet where the EC2 instance will be deployed."
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs attached to the EC2 instance."
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"
}

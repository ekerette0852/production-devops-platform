variable "project_name" {
  description = "Project name used for resource naming."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "vpc_id" {
  description = "VPC where the load balancer will be deployed."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the Application Load Balancer."
  type        = list(string)
}

variable "target_instance_id" {
  description = "EC2 instance registered with the target group."
  type        = string
}

variable "target_port" {
  description = "Port used by the application target."
  type        = number
  default     = 80
}

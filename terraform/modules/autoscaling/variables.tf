variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "launch_template_id" {
  description = "ID of the EC2 launch template"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by the Auto Scaling Group"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the Application Load Balancer target group"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of EC2 instances"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of EC2 instances"
  type        = number
  default     = 4
}

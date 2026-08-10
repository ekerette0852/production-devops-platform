variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "ami_id" {
  description = "AMI ID used by the launch template"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "security_group_id" {
  description = "Security group attached to EC2 instances"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile attached to EC2 instances"
  type        = string
}

variable "user_data" {
  description = "Bootstrap script executed when an instance launches"
  type        = string
}

output "instance_id" {
  description = "ID of the application EC2 instance."
  value       = try(aws_instance.app[0].id, null)
}

output "private_ip" {
  description = "Private IP address of the application EC2 instance."
  value       = try(aws_instance.app[0].private_ip, null)
}

output "iam_role_name" {
  description = "IAM role used by the EC2 instance."
  value       = aws_iam_role.ssm.name
}

output "ami_id" {
  description = "Amazon Linux 2023 AMI used by the instance."
  value       = data.aws_ami.amazon_linux_2023.id
}

output "instance_profile_name" {
  description = "IAM instance profile attached to EC2"
  value       = aws_iam_instance_profile.ssm.name
}

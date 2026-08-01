output "instance_id" {
  description = "ID of the application EC2 instance."
  value       = aws_instance.app.id
}

output "private_ip" {
  description = "Private IP address of the application EC2 instance."
  value       = aws_instance.app.private_ip
}

output "iam_role_name" {
  description = "IAM role used by the EC2 instance."
  value       = aws_iam_role.ssm.name
}

output "ami_id" {
  description = "Amazon Linux 2023 AMI used by the instance."
  value       = data.aws_ami.amazon_linux_2023.id
}

output "vpc_id" {
  description = "ID of the production VPC"
  value       = aws_vpc.production.id
}

output "public_subnet_id" {
  description = "ID of the production public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the production private subnet"
  value       = aws_subnet.private.id
}

output "web_instance_id" {
  description = "ID of the production web EC2 instance"
  value       = aws_instance.web.id
}

output "web_public_ip" {
  description = "Public IPv4 address of the production web server"
  value       = aws_instance.web.public_ip
}

output "web_url" {
  description = "URL of the production web application"
  value       = "http://${aws_instance.web.public_ip}"
}

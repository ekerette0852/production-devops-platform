output "load_balancer_id" {
  description = "ID of the Application Load Balancer."
  value       = aws_lb.main.id
}

output "load_balancer_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.main.arn
}

output "load_balancer_dns_name" {
  description = "Public DNS name of the Application Load Balancer."
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "ARN of the application target group."
  value       = aws_lb_target_group.app.arn
}

output "alb_security_group_id" {
  description = "Security group attached to the Application Load Balancer."
  value       = aws_security_group.alb.id
}

output "id" {
  description = "The ID of the load balancer"
  value       = aws_lb.this.id
}

output "arn" {
  description = "The arn of the load balancer"
  value       = aws_lb.this.arn
}
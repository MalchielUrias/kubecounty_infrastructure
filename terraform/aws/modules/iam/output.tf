output "role_name" {
  description = "The name of the IAM role."
  value       = module.this.iam_role_name
}

output "role_arn" {
  description = "The ARN of the IAM role."
  value       = module.this.iam_role_arn
}

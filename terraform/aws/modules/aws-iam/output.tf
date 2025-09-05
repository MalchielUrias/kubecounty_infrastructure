output "role_name" {
  description = "The name of the IAM role."
  value       = module.iam_role.iam_role_name
}

output "role_arn" {
  description = "The ARN of the IAM role."
  value       = module.iam_role.iam_role_arn
}

output "policy_arn" {
  description = "The ARN of the IAM policy."
  value       = module.iam_policy.arn
}

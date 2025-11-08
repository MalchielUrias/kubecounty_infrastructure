output "client_secret" {
  description = "Cognito App Client Secret"
  value       = aws_cognito_user_pool_client.main.client_secret
  sensitive   = true
}
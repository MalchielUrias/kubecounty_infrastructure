variable "tags" {
  type = map(string)
}

variable "acm_certificate_arn" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "price_class" {
  type = string
  default = "PriceClass_100"
}

variable "domain_name" {
  type = string
}

variable "cloudfront_oac_name" {
  type = string
}

variable "bucket_regional_domain_name" {
  type = string
}

variable "function_arn" {
  type = string
}

variable "function_event_type" {
  type = string
  default = "viewer-request"
}

variable "enable_lambda_association" {
  description = "Enable Cognito authentication via Lambda@Edge"
  type        = bool
  default     = false
}

variable "lambda_arn" {
  description = "Lambda@Edge function ARN for authentication (required if enable_cognito_auth is true)"
  type        = string
  default     = ""
}

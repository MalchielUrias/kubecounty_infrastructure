variable "function_name" {
  type = string
}

variable "function_comment" {
  type = string
}

variable "code" {
  description = "CloudFront function code"
  type        = string  # ← Just string!
}
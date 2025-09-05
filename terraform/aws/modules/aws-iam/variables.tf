variable "iam_role_name" {
  description = "Name of the IAM role to create."
  type        = string
}

variable "assume_role_policy" {
  description = "The policy that grants an entity permission to assume the role."
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy."
  type        = string
}

variable "policy_description" {
  description = "Description of the IAM policy."
  type        = string
}

variable "policy" {
  description = "The policy document."
  type        = string
}

variable "user_pool" {
  type = string
}

variable "alias_attributes" {
  type = list(string)
  default = ["preferred_username", "email"]
}

variable "auto_verified_attributes" {
  type = list(string)
  default = ["email"]
}

variable "domain_name" {
  type = string
}

variable "callback_urls" {
  type = string
}
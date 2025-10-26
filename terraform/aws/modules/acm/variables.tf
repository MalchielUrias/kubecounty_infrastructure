variable "domain_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "region" {
  type = string
  default = "us-east-1"
}
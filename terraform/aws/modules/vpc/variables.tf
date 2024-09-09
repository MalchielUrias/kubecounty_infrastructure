variable "cidr_block" {
  description = "vpc cidr block"
  type = string
}

variable "ipv6_enabled" {
  description = "ipv6 enabled"
  type = bool
}

variable "public_subnet_cidr" {
  description = "public ip cidr"
  type = string
}
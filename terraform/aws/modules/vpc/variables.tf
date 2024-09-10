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

variable "name" {
  description = "name of vpc"
  type = string
}

variable "tags" {
  description = "metadata and tags"
  type = map(string)
}
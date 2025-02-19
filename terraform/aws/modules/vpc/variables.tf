variable "cidr_block" {
  description = "vpc cidr block"
  type        = string
}

variable "ipv6_enabled" {
  description = "ipv6 enabled"
  type        = bool
  default     = true
}

variable "public_subnet_cidr" {
  description = "public ip cidr"
  type        = string
}

variable "private_subnet_cidr" {
  description = "public ip cidr"
  type        = string
}

variable "name" {
  description = "name of vpc"
  type        = string
}

variable "tags" {
  description = "metadata and tags"
  type        = map(string)
}

variable "network_interface_id" {
  description = "network interface id"
  type        = string
}

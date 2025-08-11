variable "cidr_block" {
  type = string
}

variable "ipv6_enabled" {
  type = bool
}

variable "assign_ipv6_address_on_creation" {
  type = bool
}

variable "priv_subnet_cidrs" {
  type = list(string)
}

variable "pub_subnet_cidrs" {
  type = list(string)
}

variable "name" {
  type = string
}

variable "tags" {
  type = map(string)
}
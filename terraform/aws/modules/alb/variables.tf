variable "lb_name" {
  type = string
}

variable "internal" {
  type = bool
}

variable "load_balancer_type" {
  description = "Allowed values are 'application' and 'network'"
  type = string
  default = "application"
}

variable "ip_address_type" {
  type = string
  default = "dualstack"
}

variable "security_groups" {
  type = list(string)
}

variable "idle_timeout" {
  type = number
  default = 60
}

variable "enable_deletion_protection" {
  type = bool
  default = false
}

variable "subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
  default = {}
}
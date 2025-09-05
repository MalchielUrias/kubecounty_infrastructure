variable "name" {
  type = string
}

variable "description" {
  type    = string
  default = "Security Group"
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "rules" {
  type = list(object({
    type              = string
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_blocks       = optional(list(string))
    ipv6_cidr_blocks  = optional(list(string))
  }))

  validation {
    condition = alltrue([
      for rule in var.rules :
      (
        contains(keys(rule), "cidr_blocks") || contains(keys(rule), "ipv6_cidr_blocks")
      )
    ])
    error_message = "Each rule must have at least one of cidr_blocks or ipv6_cidr_blocks."
  }
}


variable "name" {
  type = string
}

variable "description" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "rules" {
  type = list(object(
    {
      type        = string
      from_port   = number,
      to_port     = number,
      protocol    = string,
      cidr_blocks = list(string)
    }
  ))
}

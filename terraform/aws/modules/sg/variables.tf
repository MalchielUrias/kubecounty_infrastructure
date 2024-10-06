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

variable "ingress" {
  type = list(object({
    from_port   = number,
    to_port     = number,
    protocol    = string
  }))
}

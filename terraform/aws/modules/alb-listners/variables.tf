variable "load_balancer_arn" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "listener_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "target_group_arn" {
  type = string
}

variable "action_type" {
  type = string
}
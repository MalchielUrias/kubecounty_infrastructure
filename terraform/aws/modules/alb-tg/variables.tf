variable "tg_name" {
  type = string
}

variable "port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "slow_start" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "target_type" {
  type = string
}

variable "deregistration_delay" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "stickiness" {
  type        = map(any)
  default     = {}
}

variable "health_check" {
  description = "An ALB target_group healthcheck block"
  type        = map(any)
  default     = {}
}
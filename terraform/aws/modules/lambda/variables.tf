variable "filename" {
  type = string
}

variable "function_name" {
  type = string
}

variable "role" {
  type = string
}

variable "handler" {
  type = string
}

variable "source_code_hash" {
  type = string
}

variable "runtime" {
  type = string
}

variable "publish" {
  type = string
  default = "true"
}

variable "timeout" {
  type = number
  default = 5
}

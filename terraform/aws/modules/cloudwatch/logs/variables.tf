variable "log_group_name" {
  type = string
}

variable "retention" {
  type = number
}

variable "tags" {
  type = map(string)
}
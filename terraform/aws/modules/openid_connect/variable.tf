variable "client_id_list" {
  type = list(string)
  default = [
    "sts.amazonaws.com",
  ]
}

variable "url" {
  type    = string
  default = "https://token.actions.githubusercontent.com"
}

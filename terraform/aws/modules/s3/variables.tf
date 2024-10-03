variable "block_public_acls" {
  type    = bool
  default = true
}
variable "block_public_policy" {
  type    = bool
  default = true
}
variable "ignore_public_acls" {
  type    = bool
  default = true
}
variable "restrict_public_buckets" {
  type    = bool
  default = true
}
variable "policy" {
  type    = string
  default = ""
}
variable "name" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "versioning_enabled" {
  type    = bool
  default = true
}

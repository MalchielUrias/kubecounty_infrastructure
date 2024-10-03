variable "block_public_acls" {
  type = string
}
variable "block_public_policy" {
  type = string
}
variable "ignore_public_acls" {
  type = string
}
variable "restrict_public_buckets" {
  type = string
}
variable "policy" {
  type = string
}
variable "name" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "lifecycle_rule" {
  type = list(string)
}
variable "versioning_enabled" {
  type = bool
}

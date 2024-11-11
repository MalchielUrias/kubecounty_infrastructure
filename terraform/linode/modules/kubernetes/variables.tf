variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "linode_region" {
  type = string
}

variable "tags" {
  type = list(string)
}

variable "node_count" {
  type = number
}

variable "node_type" {
  type = string
}
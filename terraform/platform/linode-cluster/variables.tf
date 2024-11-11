variable "cluster_name" {
  default = "linode_cluster"
}

variable "cluster_version" {
  default = "1.31"
}

variable "node_type" {
  default = "g6-standard-2"
}

variable "node_count" {
  default = 2
}

variable "linode_region" {
  
}

variable "tags" {
  default = ["prod", "kubecounty"]
}

variable "token" {
  description = "token for access to linode resources"
  type = string
}
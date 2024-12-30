variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "associate_public_ip" {
  type = bool
}

variable "security_group_ids" {
  type = list(string)
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "desired_capacity" {
  type = number
}

variable "vpc_zone_identifier" {
  type = list(string)
}

variable "on_demand_percentage_above_base_capacity" {
  
}

variable "spot_instance_pools" {
  
}

variable "host_types" {
  
}
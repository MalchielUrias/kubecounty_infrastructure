variable "instance_type" {
  description = "instance Type for EC2"
  type        = string
}

variable "ami" {
  description = "ec2 instance ami"
  type        = string
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "key_name" {
  type = string
}

variable "network_interface" {
  type = map(object({
    device_index         = number
    network_interface_id = string
    }
  ))
  default = {}
}

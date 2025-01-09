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

variable "user_data" {
  type = string
  default = null
}

variable "iam_instance_profile" {
  type = string
  default = null
}

variable "enable_provisioner" {
  description = "Whether to enable the provisioner for EC2 instance"
  type        = bool
  default     = false
}

variable "provisioner_script" {
  description = "Path to the script for the remote-exec provisioner"
  type        = string
  default     = ""
}

variable "provisioner_ssh_user" {
  description = "SSH username for the instance"
  type        = string
  default     = "ubuntu"  # Default for Ubuntu AMIs
}

variable "provisioner_private_key_path" {
  description = "Path to the private key for SSH access"
  type        = string
}

variable "provisioner_use_private_ip" {
  description = "Whether to use the private IP for SSH connection"
  type        = bool
  default     = false
}


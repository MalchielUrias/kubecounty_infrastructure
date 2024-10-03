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

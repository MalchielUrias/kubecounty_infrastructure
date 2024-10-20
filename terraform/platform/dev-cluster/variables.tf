variable "tags" {
  default = {
    "environment" = "dev"
  }
}

variable "name" {
  default = "k3s-network"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "bastion_name" {
  default = "kubectl_jumpserver"
}

variable "bastion_sgname" {
  default = "kubectl_sg"
}

variable "bastion_description" {
  default = "This is a security group for the bastion server"
}

variable "master_description" {
  default = "This is the k3s master node"
}

variable "worker_description" {
  default = "This is the k3s worker node"
}

variable "bastion_ingress" {
  default = [
    {
      "type"        = "ingress"
      "from_port"   = 80,
      "to_port"     = 80,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "type"        = "ingress"
      "from_port"   = 22,
      "to_port"     = 22,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "type"        = "egress"
      "from_port"   = 0,
      "to_port"     = 0,
      "protocol"    = "-1",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
  ]
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0d64bb532e0502c46"
}

# variable "nat-ami" {
#   default =
#   }

variable "bastion_tags" {
  default = {
    "environment" = "dev"
    "service"     = "bastion_instance"
    "purpose"     = "ansible controller"
  }
}

variable "worker_type" {
  default = "t3.medium"
}

variable "master_type" {
  default = "t3.medium"
}

variable "worker_nodes_tags" {
  default = {
    "environment" = "dev"
    "platform"    = "kubernetes"
    "purpose"     = "worker_node"
    "setup"       = "k3s"
  }
}

variable "master_nodes_tags" {
  default = {
    "environment" = "dev"
    "platform"    = "kubernetes"
    "purpose"     = "master_node"
    "setup"       = "k3s"
  }
}

variable "key_name" {
  default = "k3s_keypair"
}

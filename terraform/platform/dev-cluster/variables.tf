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
      "from_port"   = 80,
      "to_port"     = 80,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "from_port"   = 22,
      "to_port"     = 22,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  ]
}

variable "bastion_instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0d64bb532e0502c46"
}

variable "bastion_tags" {
  default = {
    "environment" = "dev"
    "service"     = "bastion_instance"
  }
}

variable "worker_type" {
  default = "t3.small"
}

variable "master_type" {
  default = "t3.micro"
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

variable "worker_ingress" {
  default = [
    {
      "from_port"   = 22,
      "to_port"     = 22,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "from_port"   = 22,
      "to_port"     = 10250,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "from_port"   = 53,
      "to_port"     = 53,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  ]
}

variable "master_ingress" {
  default = [
    {
      "from_port"   = 22,
      "to_port"     = 22,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "from_port"   = 22,
      "to_port"     = 6443,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "from_port"   = 22,
      "to_port"     = 10250,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "from_port"   = 22,
      "to_port"     = 53,
      "protocol"    = "tcp",
      "cidr_blocks" = ["0.0.0.0/0"]
    }
  ]
}

variable "key_name" {
  default = "k3s_keypair"
}

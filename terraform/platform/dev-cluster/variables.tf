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
      "security_groups" = [module.bastion_sg.sg_id]
    },
    {
      "description" = "Allow Kubelet services from master nodes"
      "from_port"   = 10250,
      "to_port"     = 10255,
      "protocol"    = "tcp",
      "security_groups" = [module.master_node_sg.sg_id]
    },
    {
      "description" = "Allow etcd communication from master node"
      "from_port"   = 2379,
      "to_port"     = 2380,
      "protocol"    = "tcp",
      "security_groups" = [module.master_node_sg.sg_id]
    },
    {
    "description" = "Allow Cilium BPF tunneling (if enabled)"
    "from_port"   = 8472
    "to_port"     = 8472
    "protocol"    = "udp"
    "security_groups" = [module.master_node_sg.sg_id]
    },
    {
      "description" = "Allow NodePort access (if needed)"
      "from_port"   = 30000
      "to_port"     = 32767
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "from_port"   = 53,
      "to_port"     = 53,
      "protocol"    = "tcp",
      "security_groups" = [module.bastion_sg.sg_id]
    }
  ]
}

variable "master_ingress" {
  default = [
    {
      "from_port"   = 22,
      "to_port"     = 22,
      "protocol"    = "tcp",
      "security_groups" = [module.bastion_sg.sg_id]
    },
    {
      "description" = "Allow Kubernetes API access from worker nodes"
      "from_port"   = 6443,
      "to_port"     = 6443,
      "protocol"    = "tcp",
      "security_groups" = [module.worker_node_sg.sg_id]
    },
    {
      "description" = "Allow Kubelet services access from worker nodes"
      "from_port"   = 10250,
      "to_port"     = 10255,
      "protocol"    = "tcp",
      "security_groups" = [module.worker_node_sg.sg_id]
    },
    {
    "description" = "Allow etcd communication from worker nodes"
    "from_port"   = 2379
    "to_port"     = 2380
    "protocol"    = "tcp"
    "source_security_group_id" = [module.worker_node_sg.sg_id]
    },
    {
      "from_port"   = 22,
      "to_port"     = 53,
      "protocol"    = "tcp",
      "cidr_blocks" = [module.bastion_sg.sg_id]
    }
  ]
}

variable "key_name" {
  default = "k3s_keypair"
}

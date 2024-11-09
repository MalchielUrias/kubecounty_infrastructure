module "keypair" {
  source   = "../../aws/modules/keypair"
  key_name = var.key_name
}

# Create 2 worker nodes - t3.micro or t3.small
module "worker_nodes" {
  count         = 2
  source        = "../../aws/modules/ec2"
  ami           = var.ami
  instance_type = var.worker_type
  subnet_id     = module.dev_network.private_subnet_id
  tags = merge(var.worker_nodes_tags, {
    "Name" = format("Worker-Node-%s", count.index)
  })
  key_name               = module.keypair.key_name
  vpc_security_group_ids = [module.worker_node_sg.sg_id]
}

# Create 1 Master node - t3.micro or t3.small
module "master_node" {
  source        = "../../aws/modules/ec2"
  ami           = var.ami
  instance_type = var.master_type
  subnet_id     = module.dev_network.private_subnet_id
  tags = merge(var.master_nodes_tags, {
    "Name" = "Master-Node"
  })
  key_name               = module.keypair.key_name
  vpc_security_group_ids = [module.master_node_sg.sg_id]
}

# Create worker sg
module "worker_node_sg" {
  source      = "../../aws/modules/sg"
  name        = "${var.name}-worker-node"
  description = var.worker_description
  tags        = var.worker_nodes_tags
  vpc_id      = module.dev_network.vpc_id
  rules = [
    {
      "type"        = "ingress"
      "from_port"   = 22,
      "to_port"     = 22,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.1.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow Kubelet services from master nodes"
      "from_port"   = 10250,
      "to_port"     = 10255,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow BGP"
      "from_port"   = 179,
      "to_port"     = 179,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.0.0/16"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow etcd communication from master node"
      "from_port"   = 2379,
      "to_port"     = 2380,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow etcd communication from master node"
      "from_port"   = 8080,
      "to_port"     = 8080,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow Cilium BPF tunneling (if enabled)"
      "from_port"   = 8472
      "to_port"     = 8472
      "protocol"    = "udp"
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow Cilium Health Check"
      "from_port"   = 4240
      "to_port"     = 4240
      "protocol"    = "tcp"
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow NodePort access (if needed)"
      "from_port"   = 30000
      "to_port"     = 32767
      "protocol"    = "tcp"
      "cidr_blocks" = ["0.0.0.0/0"]
    },
    {
      "type"        = "ingress"
      "from_port"   = 53,
      "to_port"     = 53,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.0.0/16"]
    },
    {
      "type"        = "ingress"
      "from_port"   = 53,
      "to_port"     = 53,
      "protocol"    = "udp",
      "cidr_blocks" = ["10.0.0.0/16"]
    },
    {
      "type"        = "ingress"
      "from_port"   = 0,
      "to_port"     = 0,
      "protocol"    = "-1",
      "cidr_blocks" = ["10.45.0.0/16"]
    },
    {
      "type"        = "ingress"
      "from_port"   = -1,
      "to_port"     = -1,
      "protocol"    = "icmp",
      "cidr_blocks" = ["10.0.0.0/16"]
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


# Create master sg
module "master_node_sg" {
  source      = "../../aws/modules/sg"
  name        = "${var.name}-master-node"
  description = var.master_description
  tags        = var.master_nodes_tags
  vpc_id      = module.dev_network.vpc_id
  rules = [
    {
      "type"        = "ingress"
      "from_port"   = 22,
      "to_port"     = 22,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.1.0/24"]
    },
    {
      "type"        = "ingress"
      "from_port"   = 53,
      "to_port"     = 53,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.1.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow BGP"
      "from_port"   = 179,
      "to_port"     = 179,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.0.0/16"]
    },

    {
      "type"        = "ingress"
      "from_port"   = 53,
      "to_port"     = 53,
      "protocol"    = "udp",
      "cidr_blocks" = ["10.0.1.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow Kubernetes API access from worker nodes"
      "from_port"   = 6443,
      "to_port"     = 6443,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.2.0/24", "10.0.1.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow Kubelet services access from worker nodes"
      "from_port"   = 10250,
      "to_port"     = 10255,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow etcd communication from worker nodes"
      "from_port"   = 2379
      "to_port"     = 2380
      "protocol"    = "tcp"
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow etcd communication from master node"
      "from_port"   = 8080,
      "to_port"     = 8080,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "from_port"   = 22,
      "to_port"     = 53,
      "protocol"    = "tcp",
      "cidr_blocks" = ["10.0.1.0/24"]
    },
    {
      "type"        = "ingress"
      "from_port"   = -1,
      "to_port"     = -1,
      "protocol"    = "icmp",
      "cidr_blocks" = ["10.0.0.0/16"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow Cilium BPF tunneling (if enabled)"
      "from_port"   = 8472
      "to_port"     = 8472
      "protocol"    = "udp"
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "description" = "Allow Cilium Health Check"
      "from_port"   = 4240
      "to_port"     = 4240
      "protocol"    = "tcp"
      "cidr_blocks" = ["10.0.2.0/24"]
    },
    {
      "type"        = "ingress"
      "from_port"   = 0,
      "to_port"     = 0,
      "protocol"    = "-1",
      "cidr_blocks" = ["10.45.0.0/16"]
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

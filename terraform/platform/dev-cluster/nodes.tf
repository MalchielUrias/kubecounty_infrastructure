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
  ingress     = var.worker_ingress
  tags        = var.worker_nodes_tags
  vpc_id      = module.dev_network.vpc_id
}


# Create master sg
module "master_node_sg" {
  source      = "../../aws/modules/sg"
  name        = "${var.name}-master-node"
  description = var.master_description
  ingress     = var.master_ingress
  tags        = var.master_nodes_tags
  vpc_id      = module.dev_network.vpc_id
}

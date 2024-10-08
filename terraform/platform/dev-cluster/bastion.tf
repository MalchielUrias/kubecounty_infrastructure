

# Create Bastion Security Group
module "bastion_sg" {
  source      = "../../aws/modules/sg"
  name        = var.bastion_name
  description = var.bastion_description
  tags        = var.worker_nodes_tags
  vpc_id      = module.dev_network.vpc_id
  ingress     = var.bastion_ingress
}

# Create Bastion
module "bastion_ec2" {
  source        = "../../aws/modules/ec2"
  ami           = var.ami
  instance_type = var.bastion_instance_type
  subnet_id     = module.dev_network.public_subnet_id
  tags = merge(var.bastion_tags, {
    "Name" = "BastionServer"
  })
  key_name               = module.keypair.key_name
  vpc_security_group_ids = [module.bastion_sg.sg_id]
}

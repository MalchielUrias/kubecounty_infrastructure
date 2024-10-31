

# Create Bastion Security Group
module "bastion_sg" {
  source      = "../../aws/modules/sg"
  name        = var.bastion_name
  description = var.bastion_description
  tags        = var.worker_nodes_tags
  vpc_id      = module.dev_network.vpc_id
  rules       = var.bastion_ingress
}

# Create Bastion
module "bastion_ec2" {
  source        = "../../aws/modules/ec2"
  ami           = var.ami # this should be a nat instance ami
  instance_type = var.bastion_instance_type
  subnet_id     = module.dev_network.public_subnet_id
  tags = merge(var.bastion_tags, {
    "Name" = "BastionServer"
  })
  key_name               = module.keypair.key_name
  vpc_security_group_ids = [module.bastion_sg.sg_id]

}


# NAT Instance
module "fck-nat" {
  source = "git::https://github.com/RaJiska/terraform-aws-fck-nat.git"

  name      = "my-fck-nat"
  vpc_id    = module.dev_network.vpc_id
  subnet_id = module.dev_network.public_subnet_id
  # ha_mode              = true                 # Enables high-availability mode
  # eip_allocation_ids   = ["eipalloc-abc1234"] # Allocation ID of an existing EIP
  # use_cloudwatch_agent = true                 # Enables Cloudwatch agent and have metrics reported
  instance_type = "t4g.micro"

  update_route_tables = true
  route_tables_ids = {
    "private" = module.dev_network.private_rt_id
  }
}

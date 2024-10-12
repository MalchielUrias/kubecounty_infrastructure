# Create Network
module "dev_network" {
  source               = "../../aws/modules/vpc"
  name                 = var.name
  cidr_block           = var.cidr_block
  private_subnet_cidr  = var.private_subnet_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  network_interface_id = module.bastion_ec2.primary_network_interface_id
  tags                 = var.tags
}

# Create Private Subnet

# Create Public Subnet, For Bastion

# RouteTable

# RT Assosciation

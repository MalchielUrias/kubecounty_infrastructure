# Create Network
module "dev_network" {
  source              = "../../aws/modules/vpc"
  name                = var.name
  cidr_block          = var.cidr_block
  private_subnet_cidr = var.private_subnet_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  tags                = var.tags
}

# Create Private Subnet

# Create Public Subnet, For Bastion

# RouteTable

# RT Assosciation

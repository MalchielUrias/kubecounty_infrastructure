# Available AZs
data "aws_availability_zones" "available" {
  state = "available"
}

# Setup Locals
locals {
  priv_subnet_cidr = { for i, v in var.priv_subnet_cidrs : i => v }

  pub_subnet_cidr = { for i, v in var.pub_subnet_cidrs : i => v }

  # Calculate IPv6 subnet indexes
  # Private subnets start at index 0
  priv_ipv6_cidrs = { for k, v in local.priv_subnet_cidr : k => 
    cidrsubnet(aws_vpc.this.ipv6_cidr_block, 8, tonumber(k))
  }
  
  # Public subnets start after private subnets
  pub_ipv6_cidrs = { for k, v in local.pub_subnet_cidr : k => 
    cidrsubnet(aws_vpc.this.ipv6_cidr_block, 8, tonumber(k) + length(local.priv_subnet_cidr))
  }
}

# ======= Create VPC ========
resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  assign_generated_ipv6_cidr_block = var.ipv6_enabled

  tags = merge(var.tags, { "Name" = "${var.name}_vpc" })
}

# Create Subnets
resource "aws_subnet" "priv_subnet" {
  for_each = local.priv_subnet_cidr
  vpc_id = aws_vpc.this.id
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  ipv6_cidr_block = var.ipv6_enabled ? local.priv_ipv6_cidrs[each.key] : null
  cidr_block = each.value
  availability_zone = data.aws_availability_zones.available.names[each.key]
}

resource "aws_subnet" "pub_subnet" {
  for_each = local.pub_subnet_cidr
  vpc_id = aws_vpc.this.id
  map_public_ip_on_launch = true 
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  ipv6_cidr_block = var.ipv6_enabled ? local.pub_ipv6_cidrs[each.key] : null
  cidr_block = each.value
  availability_zone = data.aws_availability_zones.available.names[each.key]
}

# Create RT
resource "aws_route_table" "priv" {
  for_each =  local.priv_subnet_cidr
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  dynamic "route" {
    for_each = var.ipv6_enabled ? [1] : []
    content {
      ipv6_cidr_block        = "::/0"
      egress_only_gateway_id = aws_egress_only_internet_gateway.this[0].id
    }
  }
  
}

resource "aws_route_table" "pub" {
  for_each = local.pub_subnet_cidr
  vpc_id = aws_vpc.this.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.this.id
  }
}


# Create NAT Gateway
# resource "aws_eip" "this" {
#   domain = "vpc"

#   tags = {
#     Name = "NAT Gateway EIP"
#   }
# }

# resource "aws_nat_gateway" "this" {
#   allocation_id = aws_eip.this.id

#   subnet_id = aws_subnet.pub_subnet[0].id

#   tags = {
#     Name = "${var.name}-natgw"
#   }
# }

# Add Egress-only Internet Gateway for IPv6
resource "aws_egress_only_internet_gateway" "this" {
  count  = var.ipv6_enabled ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-eigw"
  }
}

# Create IGW
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id 

  tags = {
    Name = "${var.name}-igw"
  }
}

# ======= RT Association =======
resource "aws_route_table_association" "priv" {
  for_each = local.priv_subnet_cidr
  subnet_id = aws_subnet.priv_subnet[each.key].id 
  route_table_id = aws_route_table.priv[each.key].id
}

resource "aws_route_table_association" "pub" {
  for_each = local.pub_subnet_cidr
  subnet_id = aws_subnet.pub_subnet[each.key].id 
  route_table_id = aws_route_table.pub[each.key].id
}
# Create VPC
resource "aws_vpc" "this" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames             = true
  enable_dns_support               = true
  assign_generated_ipv6_cidr_block = var.ipv6_enabled

  tags = {
    Name = "KubeCounty VPC"
  }
}

# Create Subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.public_subnet_cidr


  tags = {
    Name = "Public Subnet"
  }
}
# Create IGW
resource "aws_internet_gateway" "kubecounty_igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "KubeCounty VPC IGW"
  }
}

# Create Route 
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.kubecounty_igw.id
}

resource "aws_route" "public_internet_gateway_ipv6" {
  route_table_id              = aws_route_table.public.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.kubecounty_igw.id
}


# Create Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
      "Name" = "KubeCounty Public Route"
  }
}

# Create Route Table Association
resource "aws_route_table_association" "pub" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
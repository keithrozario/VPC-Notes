provider "aws" {
  profile = "default"
  region = "ap-southeast-1"
}

# Creates a VPC with ipv4 and ipv6 enabled
resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  assign_generated_ipv6_cidr_block = true # unable to specify cidr block of ipv6 
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "main"
    Stage = "Prod"
  }
}


# Public Subnet
resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-1b"
  map_public_ip_on_launch = true # auto assigns public IP addresses to EC2s in this subnet

  tags = {
    Name = "Public"
    Stage = "Prod"
  }
}

resource "aws_ssm_parameter" "public_subnet_id" {
  name = "/security/public_subnet_id"
  type = "String"
  value = "${aws_subnet.public.id}"
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "main"
    Stage = "Prod"
  }
}

## EIP and NAT Gateway

resource "aws_eip" "nat_gateway_eip" {
  vpc      = true
}


resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat_gateway_eip.id}"
  subnet_id     = "${aws_subnet.public.id}"
} 

# Route Table
resource "aws_route_table" "public_route" {
  vpc_id = "${aws_vpc.main.id}"

  # Note that the default route, mapping the VPC's CIDR block to "local", 
  # is created implicitly and cannot be specified.
  #
  # route {
  #   cidr_block = "10.0.0.0/16"
  #   gateway_id = "local"
  # }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "Public"
  }
}

# Associate public route table to public subnet
resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public_route.id}"
}
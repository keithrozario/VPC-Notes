# Private Subnet with NAT
resource "aws_subnet" "private_nat" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Private_with_internet"
    Stage = "Prod"
  }
}

resource "aws_ssm_parameter" "private_with_nat_subnet_id" {
  name = "/security/private_with_nat_subnet_id"
  type = "String"
  value = "${aws_subnet.private_nat.id}"
}

# Default table is associated with the private subnet
resource "aws_default_route_table" "r" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags = {
    Name = "Default table"
  }
}

# Private Subnet No Internet with Endpoint
resource "aws_subnet" "private_no_internet_with_endpoint" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "Private_no_internet_with_endpoint"
    Stage = "Prod"
  }
}

resource "aws_ssm_parameter" "private_no_internet_with_endpoint_subnet_id" {
  name = "/security/private_no_internet_with_endpoint_subnet_id"
  type = "String"
  value = "${aws_subnet.private_no_internet_with_endpoint.id}"
}

resource "aws_route_table" "private_no_internet_with_endpoint" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "Private No Internet With endpoint"
  }
}

resource "aws_route_table_association" "no_internet_with_endpoint_route_table_association" {
  subnet_id      = "${aws_subnet.private_no_internet_with_endpoint.id}"
  route_table_id = "${aws_route_table.private_no_internet_with_endpoint.id}"
}

# Private Subnet No Internet with Endpoint

resource "aws_subnet" "private_no_internet_no_endpoint" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "Private_no_internet_no_VPC"
    Stage = "Prod"
  }
}

resource "aws_ssm_parameter" "private_no_internet_no_endpoint_id" {
  name = "/security/private_no_internet_no_endpoint_subnet_id"
  type = "String"
  value = "${aws_subnet.private_no_internet_no_endpoint.id}"
}

resource "aws_route_table" "private_no_internet_no_endpoint" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "Private No Internet No endpoint"
  }
}

resource "aws_route_table_association" "no_internet_route_table_association" {
  subnet_id      = "${aws_subnet.private_no_internet_no_endpoint.id}"
  route_table_id = "${aws_route_table.private_no_internet_no_endpoint.id}"
}
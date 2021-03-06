resource "aws_vpc_endpoint" "s3" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "com.amazonaws.ap-southeast-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = ["${aws_route_table.private_no_internet_with_endpoint.id}"]

}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = "${aws_vpc.main.id}"
  service_name      = "com.amazonaws.ap-southeast-1.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = ["${aws_subnet.private_no_internet_with_endpoint.id}"]

  security_group_ids = [
    "${aws_security_group.vpc_endpoint.id}"
  ]
  private_dns_enabled = true # when this is set to false the interface endpoints won't work

}
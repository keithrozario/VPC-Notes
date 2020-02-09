# resource "aws_network_acl" "public_acl" {
#   vpc_id = "${aws_vpc.main.id}"
#   subnet_ids = ["${aws_subnet.public.id}"]

#   egress {
#     protocol   = "udp"
#     rule_no    = 200
#     action     = "allow"
#     cidr_block = "1.1.1.1/32"
#     from_port  = 53
#     to_port    = 53
#   }

#   ingress {
#     protocol   = "udp"
#     rule_no    = 201
#     action     = "allow"
#     cidr_block = "1.1.1.1/32"
#     from_port  = 1024
#     to_port    = 65535
#   }

# egress {
#     protocol   = "udp"
#     rule_no    = 202
#     action     = "allow"
#     cidr_block = "8.8.8.8/32"
#     from_port  = 53
#     to_port    = 53
#   }

#   ingress {
#     protocol   = "udp"
#     rule_no    = 203
#     action     = "allow"
#     cidr_block = "8.8.8.8/32"
#     from_port  = 1024
#     to_port    = 65535
#   }

#   ingress {
#     protocol   = "tcp"
#     rule_no    = 300
#     action     = "allow"
#     cidr_block = "10.0.2.0/24"
#     from_port  = 22
#     to_port    = 22
#   }

#   egress {
#     protocol   = "tcp"
#     rule_no    = 301
#     action     = "allow"
#     cidr_block = "10.0.2.0/24"
#     from_port  = 1024
#     to_port    = 65535
#   }

#   tags = {
#     Name = "main"
#   }
# }

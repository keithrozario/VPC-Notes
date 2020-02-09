# # in order to use this properly, set the enable_dns_support flag on the VPC to false

# resource "aws_vpc_dhcp_options" "dns_resolver" {
#   domain_name_servers = ["1.1.1.1", "8.8.4.4"]
# }

# resource "aws_vpc_dhcp_options_association" "dns_resolver" {
#   vpc_id          = "${aws_vpc.main.id}"
#   dhcp_options_id = "${aws_vpc_dhcp_options.dns_resolver.id}"
# }

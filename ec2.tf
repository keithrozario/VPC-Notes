# Generic Keypair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKoSIq1u1CTYLIVxD3FLZ/TT9qRllOCXKXDN9MBWz5poMoz1uqh7Tg4qof3nfbETVP5YsTKVFG/8fzmur3IKcFclNiHZ7KR4CadBW1/ThQOXw99Cz3aAoAW85fqM7d54kRQ4BXL31iunJj/gD9t6Ak/++wbroQ50g66q8q7NRks5Kes4Wmh5Ccn8BrUuWlYeRTf65tTXb/iHm/pwTciBFMS8uyBp/4UeCH4rYwMTzu2wYUhUy66wSbbrJZ1aADyqgytoCWGflsHWLUQ8uoRmI/REW0XQuEym5SqpWKzChRqEuazx9UX8qhnS7eoGthmnGCLB3fFcYakpipsw84IuPj keithrozario@keiths-mbp.lan"
}

# Ubuntu AMI
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "public" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_tls_ssh.id}"]
  key_name = "deployer-key"

  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"

  tags = {
    Name = "Public"
  }
}

resource "aws_instance" "private" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private_nat.id}"
  vpc_security_group_ids = ["${aws_security_group.private_security_group.id}"]
  key_name = "deployer-key"

  iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"

  tags = {
    Name = "Private"
  }
}
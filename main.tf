resource "aws_instance" "vm1" {
  ami                    = "ami-0cbe318e714fc9a82"
  availability_zone      = "us-west-1"
  instance_type          = "t2.micro"
  key_name               = "aws"
  vpc_security_group_ids = [aws_security_group.sg1.id]
  depends_on             = [aws_security_group.sg1]

  tags = {
    Name = "test-vm1"
  }
}

resource "aws_security_group" "sg1" {
  name        = "allow_http"
  description = "Allow http inbound traffic and all outbound traffic"

  tags = {
    Name = "allow_http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
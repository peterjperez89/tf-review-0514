resource "aws_security_group" "sg1" {
  name = var.sgname
  description = "security group for webapp"
  vpc_id = var.vpc
  
}

resource "aws_vpc_security_group_ingress_rule" "ingress1" {
  security_group_id = aws_security_group.sg1.id
  description = "ingress rule for http"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "ingress2" {
  security_group_id = aws_security_group.sg1.id
  description = "ingress rule for https"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "ingress3" {
  security_group_id = aws_security_group.sg1.id
  description = "ingress rule for ssh"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "egress1" {
  security_group_id = aws_security_group.sg1.id
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
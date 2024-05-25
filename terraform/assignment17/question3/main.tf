//vpc
resource "aws_vpc" "sourcevpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

//public subnets
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.sourcevpc.id
  cidr_block              = var.subnet1_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet1"
  }
}

//internet gateway
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.sourcevpc.id

  tags = {
    Name = "igw1"
  }
}

//route table
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.sourcevpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }
  tags = {
    Name = "rt1"
  }
}

//route table association
resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt1.id
}

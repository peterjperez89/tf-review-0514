variable "vpc_cidr_block" {
  description = "cidr block for VPC"
  type = string
}

variable "vpc_name" {
  description = "name of VPC"
  type = string
}

variable "subnet1_cidr_block" {
  description = "cidr block for public subnet"
  type = string
}

variable "availability_zone" {
  description = "availability zone"
  type = string
}
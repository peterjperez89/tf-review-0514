variable "cidr_block" {
  type = string
  description = "value of cidr block"
}

variable "cidr_s1" {
  type = string
  description = "value of cidr block for subnet 1"
}

variable "az1" {
  type = string
  description = "availability zone for s1"
}

variable "cidr_s2" {
  type = string
  description = "value of cidr block for subnet 2"
}

variable "az2" {
  type = string
  description = "availability zone for s2"
}

variable "cidr_rt" {
  type = string
  description = "value of cidr block for route table"
}
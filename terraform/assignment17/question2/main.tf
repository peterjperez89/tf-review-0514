// data blocks for vpc and subnets
data "aws_vpc" "defvpc" {
  default = true
}

data "aws_subnet" "defsubnet1" {
  id = "subnet-0115516ea7bff372e"
}

data "aws_subnet" "defsubnet2" {
  id = "subnet-0e3f0b4cf80135465"
}


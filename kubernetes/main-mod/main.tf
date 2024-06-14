module "vpc" {
  source     = "./vpc"
  cidr_block = "192.168.0.0/16"
  cidr_s1    = "192.168.1.0/24"
  az1        = "us-west-1a"
  cidr_s2    = "192.168.2.0/24"
  az2        = "us-west-1c"
  cidr_rt    = "0.0.0.0/0"
}

module "lt-sg" {
  source     = "./lt-sg"
  vpcid      = module.vpc.vpcid
  depends_on = [module.vpc]
}

module "eks" {
  source     = "./eks"
  sub1id     = module.vpc.sub1id
  sub2id     = module.vpc.sub2id
  sgid       = module.lt-sg.sgid
  ltid       = module.lt-sg.ltid
  ltver      = module.lt-sg.ltver
  depends_on = [module.lt-sg]
}

# Create an EBS volume
resource "aws_ebs_volume" "example" {
  availability_zone = "us-west-1c"
  size              = 5
  tags = {
    Name = "example-ebs-volume"
  }
}
output "volume_id" {
  value = aws_ebs_volume.example.id
}
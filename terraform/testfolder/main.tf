module "myec2" {
  source       = "./modules/ec2"
  ami          = "ami-0cbe318e714fc9a82"
  itype        = "t2.micro"
  az           = "us-west-1a"
  key          = "aws"
  sgid         = module.sg.sgid
  instancename = "webapp1"
  depends_on   = [module.sg]
}

module "sg" {
  source = "./modules/sg"
  sgname = "sg1"
  vpc    = "vpc-075cec1e52d1d5e0f"
}

module "backend" {
  source       = "./modules/backend"
  dynamodbname = "table1"
  versstatus   = "Enabled"
  bucket_name  = "atlasbucket05192024"
}
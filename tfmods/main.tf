module "iam" {
  source = "./modules/iam"

  group = "group1"
}

module "ec2" {
  source = "./modules/ec2"

  az = "us-west-1c"
  instancename = module.iam.username
}
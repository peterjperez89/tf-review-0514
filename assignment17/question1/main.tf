module "ec2" {
  source = "./modules/ec2"
}

module "iam" {
  source = "./modules/iam"
}

module "s3" {
  source = "./modules/s3"
}
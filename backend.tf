terraform {
  backend "s3" {
    bucket  = "pjtf-state-bucket"
    key     = "state-files/terraform.tfstate"
    region  = "us-west-1"
    profile = "tfuser"

  }
}
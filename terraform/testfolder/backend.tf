terraform {
  backend "s3" {
    bucket         = "atlasbucket05192024"
    key            = "statefiles/terraform.tfstate"
    region         = "us-west-1"
    profile        = "tfuser"
    dynamodb_table = "table1"
  }
}
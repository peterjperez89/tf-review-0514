provider "aws" {
  region                   = "us-west-1"
  profile                  = "tfuser"
  shared_credentials_files = ["~/.aws/credentials"]
}
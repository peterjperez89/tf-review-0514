variable "bucket_name" {
  description = "variable name for s3 bucket"
  type        = string
  default     = "pjtf-state-bucket"
}

#Variables for ec2_sg.terraform {

variable "ami_id" {
  description = "ami_id for aws linux instance"
  type        = string
  default     = "ami-0cbe318e714fc9a82"
}

variable "az" {
  description = "availability for aws linux instance"
  type        = string
  default     = "us-west-1a"
}
variable "key" {
  description = "authentication key for aws linux instance"
  type        = string
  default     = "aws"
}
variable "instance_type" {
  description = "instance_type for aws linux instance"
  type        = string
  default     = "t2.micro"
}
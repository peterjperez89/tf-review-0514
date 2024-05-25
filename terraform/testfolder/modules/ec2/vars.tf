variable "ami" {
  type        = string
  description = "ami"
}

variable "itype" {
  type        = string
  description = "instance type"
}

variable "az" {
  type        = string
  description = "availability zone"
}

variable "key" {
  type        = string
  description = "key name"
}

variable "sgid" {
  type        = string
  description = "security group id"
}

variable "instancename" {
  type        = string
  description = "instance name"
}
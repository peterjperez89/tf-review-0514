variable "bucket_name" {
  type = string
  description = "name of s3 bucket"
}

variable "versstatus" {
  type = string
  description = "versioning config status"
}

variable "dynamodbname" {
  type = string
  description = "name of table"
}
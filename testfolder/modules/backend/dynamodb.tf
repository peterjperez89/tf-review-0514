resource "aws_dynamodb_table" "db1" {
  name = var.dynamodbname
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
resource "aws_s3_bucket" "tfbucket1" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "tfbucket1vers" {
  bucket = aws_s3_bucket.tfbucket1.id
  versioning_configuration {
    status = var.versstatus
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfbuck" {
  bucket = aws_s3_bucket.tfbucket1.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
      kms_master_key_id = aws_kms_key.awskey.id
    }
  }
  depends_on = [ aws_kms_key.awskey ]
}

resource "aws_kms_key" "awskey" {
  key_usage = "ENCRYPT_DECRYPT"
  description = "key for s3 bucket"
}
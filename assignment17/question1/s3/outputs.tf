output "s3bucketname" {
  value = aws_s3_bucket.s3bucket.bucket_domain_name
}
resource "aws_s3_bucket_policy" "b" {
  bucket = var.bucket_name
  policy = var.bucket_policy
}
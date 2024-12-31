resource "aws_s3_object" "object" {
  bucket = var.bucket_name
  key    = var.key
  source = var.object_source
}
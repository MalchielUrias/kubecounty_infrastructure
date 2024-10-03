resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.policy != "" ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = var.policy
}

resource "aws_s3_bucket" "this" {
  bucket        = var.name
  force_destroy = false
  acl           = "private"
  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.name)
    },
  )
  versioning {
    enabled = var.versioning_enabled
  }
}

resource "aws_s3_bucket" "ada_s3_achilles" {
  bucket        = "${var.bucket_name}-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "ada-bucket-app"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.ada_s3_achilles.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.ada_s3_achilles.id
  policy = local.policy
}

resource "aws_s3_bucket" "state_bucket" {
  bucket        = "unique-state-bucket-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "unique-state-bucket"
    Environment = var.environment
  }
}

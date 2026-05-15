# main.tf

provider "aws" {
  region = "ap-south-1"
}

# Create S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "deepak-demo-bucket-xx-12345"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}

# Enable Versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable Server Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Output Bucket Name
output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

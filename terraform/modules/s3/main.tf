# Note: State bucket is created in terraform_bootstrap/main.tf
# This module only manages the image specifications bucket

# S3 bucket for image specifications
resource "aws_s3_bucket" "image_specs" {
  bucket        = var.image_specs_bucket_name
  force_destroy = true

  tags = merge(var.common_tags, {
    Name = "Image Specifications Bucket"
    Purpose = "Image Specification Storage"
  })
}

resource "aws_s3_bucket_versioning" "image_specs" {
  bucket = aws_s3_bucket.image_specs.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption for the image specs bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "image_specs" {
  bucket = aws_s3_bucket.image_specs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to the image specs bucket
resource "aws_s3_bucket_public_access_block" "image_specs" {
  bucket = aws_s3_bucket.image_specs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# IAM policy for the image specs bucket (read-only access for Image Builder)
resource "aws_s3_bucket_policy" "image_specs" {
  bucket = aws_s3_bucket.image_specs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowImageBuilderReadAccess"
        Effect = "Allow"
        Principal = {
          Service = "imagebuilder.amazonaws.com"
        }
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion"
        ]
        Resource = "${aws_s3_bucket.image_specs.arn}/*"
      }
    ]
  })
}

# S3 bucket for Terraform state and versioning
resource "aws_s3_bucket" "tfstate" {
  bucket = "golden-imagebuilder-tfstate"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to the S3 bucket
resource "aws_s3_bucket_public_access_block" "tfstate" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Explicitly define the S3 backend to use existing resources
terraform {
  backend "s3" {
    bucket       = "golden-imagebuilder-tfstate"
    key          = "golden-imagebuilder/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
} 
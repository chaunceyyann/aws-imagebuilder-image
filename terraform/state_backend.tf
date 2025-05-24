resource "aws_s3_bucket" "terraform_state" {
  bucket = "docker-image-4codebuild-tfstate"

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "docker-image-4codebuild-tfstate-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

# Explicitly define the S3 backend
terraform {
  backend "s3" {
    bucket         = "docker-image-4codebuild-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "docker-image-4codebuild-tfstate-lock"
  }
} 
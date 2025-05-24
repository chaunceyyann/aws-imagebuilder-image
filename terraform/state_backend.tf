resource "aws_s3_bucket" "tfstate" {
  bucket = "docker-image-4codebuild-tfstate"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_dynamodb_table" "tfstate_lock" {
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
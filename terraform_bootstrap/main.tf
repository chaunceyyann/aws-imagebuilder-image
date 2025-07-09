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
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

# Explicitly define the S3 backend to use existing resources
terraform {
  backend "s3" {
    bucket       = "golden-imagebuilder-tfstate"
    key          = "golden-imagebuilder/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
} 
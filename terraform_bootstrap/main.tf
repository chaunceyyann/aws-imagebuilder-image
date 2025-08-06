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

resource "aws_s3_bucket" "image_specs" {
  bucket = "golden-imagebuilder-image-specs"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "image_specs" {
  bucket = aws_s3_bucket.image_specs.id
  versioning_configuration {
    status = "Enabled"
  }
}

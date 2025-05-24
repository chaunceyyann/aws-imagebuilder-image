# Note: The S3 bucket and DynamoDB table for state and lock are already created.
# Terraform will use these existing resources for state management.

# If the DynamoDB table does not exist, uncomment the following to create it:
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

# Explicitly define the S3 backend to use existing resources
terraform {
  backend "s3" {
    bucket         = "docker-image-4codebuild-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    # dynamodb_table parameter removed to disable locking temporarily for testing
  }
} 
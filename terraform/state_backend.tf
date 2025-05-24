# Note: The S3 bucket and DynamoDB table for state and lock are already created.
# Terraform will use these existing resources for state management.

# Explicitly define the S3 backend to use existing resources
terraform {
  backend "s3" {
    bucket         = "docker-image-4codebuild-tfstate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "docker-image-4codebuild-tfstate-lock"
  }
} 
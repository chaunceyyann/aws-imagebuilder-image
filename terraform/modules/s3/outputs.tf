output "tfstate_bucket_name" {
  description = "Name of the Terraform state bucket"
  value       = aws_s3_bucket.tfstate.bucket
}

output "tfstate_bucket_arn" {
  description = "ARN of the Terraform state bucket"
  value       = aws_s3_bucket.tfstate.arn
}

output "image_specs_bucket_name" {
  description = "Name of the image specifications bucket"
  value       = aws_s3_bucket.image_specs.bucket
}

output "image_specs_bucket_arn" {
  description = "ARN of the image specifications bucket"
  value       = aws_s3_bucket.image_specs.arn
} 
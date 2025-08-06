# State bucket is managed in terraform_bootstrap/main.tf

# State bucket is managed in terraform_bootstrap/main.tf

output "image_specs_bucket_name" {
  description = "Name of the image specifications bucket"
  value       = aws_s3_bucket.image_specs.bucket
}

output "image_specs_bucket_arn" {
  description = "ARN of the image specifications bucket"
  value       = aws_s3_bucket.image_specs.arn
}

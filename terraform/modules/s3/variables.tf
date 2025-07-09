variable "tfstate_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
}

variable "image_specs_bucket_name" {
  description = "Name of the S3 bucket for image specifications"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
} 
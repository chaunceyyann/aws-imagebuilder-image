output "amazon_linux_2023_pipeline_arn" {
  description = "ARN of the Amazon Linux 2023 Image Builder pipeline"
  value       = aws_imagebuilder_image_pipeline.amazon_linux_2023_pipeline.arn
}

output "ubuntu_2024_pipeline_arn" {
  description = "ARN of the Ubuntu 2024 Image Builder pipeline"
  value       = aws_imagebuilder_image_pipeline.ubuntu_2024_pipeline.arn
}

output "windows_server_2022_pipeline_arn" {
  description = "ARN of the Windows Server 2022 Image Builder pipeline"
  value       = aws_imagebuilder_image_pipeline.windows_server_2022_pipeline.arn
} 
output "linux_pipeline_arns" {
  description = "ARNs of the Linux Image Builder pipelines"
  value       = {
    for name, pipeline in aws_imagebuilder_image_pipeline.linux_pipelines :
    name => pipeline.arn
  }
}

output "windows_pipeline_arns" {
  description = "ARNs of the Windows Image Builder pipelines"
  value       = {
    for name, pipeline in aws_imagebuilder_image_pipeline.windows_pipelines :
    name => pipeline.arn
  }
}

output "all_pipeline_arns" {
  description = "All Image Builder pipeline ARNs"
  value       = merge(
    {
      for name, pipeline in aws_imagebuilder_image_pipeline.linux_pipelines :
      "linux_${name}" => pipeline.arn
    },
    {
      for name, pipeline in aws_imagebuilder_image_pipeline.windows_pipelines :
      "windows_${name}" => pipeline.arn
    }
  )
}

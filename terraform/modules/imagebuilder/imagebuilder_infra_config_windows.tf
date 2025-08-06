resource "aws_imagebuilder_infrastructure_configuration" "windows_config" {
  name                          = "WindowsImageBuilderConfig"
  description                   = "Infrastructure configuration for Windows image builds"
  instance_types                = ["t3.large"]  # Windows may require more resources
  instance_profile_name         = aws_iam_instance_profile.imagebuilder_profile.name
  terminate_instance_on_failure = true

  tags = {
    Project = "GoldenImageBuilder"
  }
}

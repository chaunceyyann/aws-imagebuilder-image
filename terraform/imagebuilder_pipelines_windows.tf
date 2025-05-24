resource "aws_imagebuilder_image_pipeline" "windows_server_2022_pipeline" {
  name                             = "WindowsServer2022Pipeline"
  description                      = "Pipeline for building Windows Server 2022 Golden AMI"
  image_recipe_arn                 = aws_imagebuilder_image_recipe.windows_server_2022.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.windows_config.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.ami_distribution.arn
  image_tests_configuration {
    image_tests_enabled = true
    timeout_minutes     = 120  # Longer timeout for Windows builds
  }
  schedule {
    schedule_expression = "cron(0 0 * * ? *)"  # Daily builds
    pipeline_execution_start_condition = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE"
  }

  tags = {
    Project = "StreamlinedImageCreation"
  }
} 
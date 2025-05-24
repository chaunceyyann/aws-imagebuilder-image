resource "aws_imagebuilder_image_pipeline" "amazon_linux_2023_pipeline" {
  name                             = "AmazonLinux2023Pipeline"
  description                      = "Pipeline for building Amazon Linux 2023 Golden AMI"
  image_recipe_arn                 = aws_imagebuilder_image_recipe.amazon_linux_2023.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.linux_config.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.ami_distribution.arn
  image_tests_configuration {
    image_tests_enabled = true
    timeout_minutes     = 60
  }
  schedule {
    schedule_expression = "cron(0 0 * * ? *)"  # Daily builds
    pipeline_execution_start_condition = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE"
  }

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_imagebuilder_image_pipeline" "ubuntu_2024_pipeline" {
  name                             = "Ubuntu2024Pipeline"
  description                      = "Pipeline for building Ubuntu 2024 Golden AMI"
  image_recipe_arn                 = aws_imagebuilder_image_recipe.ubuntu_2024.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.linux_config.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.ami_distribution.arn
  image_tests_configuration {
    image_tests_enabled = true
    timeout_minutes     = 60
  }
  schedule {
    schedule_expression = "cron(0 0 * * ? *)"  # Daily builds
    pipeline_execution_start_condition = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE"
  }

  tags = {
    Project = "StreamlinedImageCreation"
  }
} 
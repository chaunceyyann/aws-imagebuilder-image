resource "aws_imagebuilder_distribution_configuration" "ami_distribution" {
  name        = "AMIDistributionConfig"
  description = "Distribution configuration for AMIs"

  distribution {
    region = "us-east-1"
    ami_distribution_configuration {
      name = "GoldenAMI-{{ imagebuilder:buildDate }}"
      ami_tags = {
        Project = "GoldenImageBuilder"
      }
    }
  }

  tags = {
    Project = "GoldenImageBuilder"
  }
} 
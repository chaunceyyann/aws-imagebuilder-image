resource "aws_imagebuilder_infrastructure_configuration" "linux_config" {
  name                          = "LinuxImageBuilderConfig"
  description                   = "Infrastructure configuration for Linux image builds"
  instance_types                = ["t3.medium"]
  instance_profile_name         = aws_iam_instance_profile.imagebuilder_profile.name
  terminate_instance_on_failure = true

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_iam_instance_profile" "imagebuilder_profile" {
  name = "ImageBuilderInstanceProfile"
  role = aws_iam_role.imagebuilder_role.name
}

resource "aws_iam_role" "imagebuilder_role" {
  name = "ImageBuilderRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "imagebuilder_policy" {
  role = aws_iam_role.imagebuilder_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:CreateSnapshot",
          "ec2:DeleteSnapshot",
          "ec2:CreateTags",
          "ec2:CreateImage",
          "ec2:RegisterImage",
          "ec2:DeregisterImage",
          "ec2:DescribeImages",
          "ec2:DescribeSnapshots",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:ModifyImageAttribute",
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "imagebuilder:GetComponent",
          "imagebuilder:GetContainerRecipe",
          "imagebuilder:GetImage",
          "imagebuilder:GetImageRecipe",
          "imagebuilder:ListComponents",
          "imagebuilder:ListContainerRecipes",
          "imagebuilder:ListImageRecipes",
          "imagebuilder:ListImages",
          "imagebuilder:CreateComponent",
          "imagebuilder:CreateContainerRecipe",
          "imagebuilder:CreateImage",
          "imagebuilder:CreateImageRecipe",
          "imagebuilder:DeleteComponent",
          "imagebuilder:DeleteContainerRecipe",
          "imagebuilder:DeleteImageRecipe",
          "imagebuilder:StartImagePipelineExecution"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
} 
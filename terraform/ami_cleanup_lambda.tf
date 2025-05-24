resource "aws_lambda_function" "ami_cleanup" {
  filename         = "ami_cleanup.zip"
  function_name    = "AMICleanupFunction"
  role             = aws_iam_role.lambda_role.arn
  handler          = "ami_cleanup.lambda_handler"
  source_code_hash = filebase64sha256("ami_cleanup.zip")
  runtime          = "python3.9"
  timeout          = 300

  environment {
    variables = {
      TAG_KEY   = "Project"
      TAG_VALUE = "StreamlinedImageCreation"
      KEEP_LATEST = "1"
    }
  }

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "AMICleanupLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_role.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeImages",
          "ec2:DeregisterImage",
          "ec2:DescribeSnapshots",
          "ec2:DeleteSnapshot",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_cloudwatch_event_rule" "image_builder_completion" {
  name        = "ImageBuilderCompletionRule"
  description = "Triggers Lambda on Image Builder completion"

  event_pattern = jsonencode({
    source = ["aws.imagebuilder"]
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      eventSource = ["imagebuilder.amazonaws.com"]
      eventName = ["CreateImage"]
    }
  })

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.image_builder_completion.name
  target_id = "AMICleanupLambda"
  arn       = aws_lambda_function.ami_cleanup.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ami_cleanup.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.image_builder_completion.arn
} 
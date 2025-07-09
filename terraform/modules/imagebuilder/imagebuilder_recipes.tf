resource "aws_imagebuilder_image_recipe" "amazon_linux_2023" {
  name         = "AmazonLinux2023Recipe"
  description  = "Recipe for Amazon Linux 2023 with multiple components"
  version      = "1.0.0"
  parent_image = "arn:aws:imagebuilder:us-east-1:aws:image/amazon-linux-2023-x86/x.x.x"

  component {
    component_arn = aws_imagebuilder_component.falcon_sensor.arn
    parameter {
      name  = "FalconRpmUrl"
      value = "https://your-falcon-repo.com/falcon-sensor.rpm"
    }
    parameter {
      name  = "FalconDebUrl"
      value = "https://your-falcon-repo.com/falcon-sensor.deb"
    }
    parameter {
      name  = "CustomerId"
      value = "your-actual-customer-id"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.cloudwatch_agent.arn
    parameter {
      name  = "ConfigS3Path"
      value = "s3://your-bucket/cloudwatch-agent-config-al2023.json"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.python.arn
    parameter {
      name  = "AdditionalPackages"
      value = "boto3 awscli requests"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.nodejs.arn
    parameter {
      name  = "NvmVersion"
      value = "v0.39.1"
    }
    parameter {
      name  = "NodeVersion"
      value = "--lts"
    }
    parameter {
      name  = "GlobalPackages"
      value = "yarn pm2"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.aws_cli.arn
    parameter {
      name  = "AwsCliVersion"
      value = "latest"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.terraform_tflint.arn
    parameter {
      name  = "TerraformVersion"
      value = "1.5.0"
    }
    parameter {
      name  = "TflintVersion"
      value = "v0.47.0"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.systemd_timesyncd.arn
    parameter {
      name  = "NtpServers"
      value = "0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.prometheus_exporters.arn
    parameter {
      name  = "NodeExporterVersion"
      value = "1.6.1"
    }
    parameter {
      name  = "AdditionalExporters"
      value = ""
    }
  }

  component {
    component_arn = aws_imagebuilder_component.splunk_indexer.arn
    parameter {
      name  = "SplunkInstallerUrl"
      value = "https://download.splunk.com/products/splunk/releases/9.1.0/linux/splunk-9.1.0-9e907cedecb1.x86_64.rpm"
    }
    parameter {
      name  = "AdminPassword"
      value = "your-splunk-password"
    }
  }

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_image_recipe" "ubuntu_2024" {
  name         = "Ubuntu2024Recipe"
  description  = "Recipe for Ubuntu 2024 with multiple components"
  version      = "1.0.0"
  parent_image = "arn:aws:imagebuilder:us-east-1:aws:image/ubuntu-24-04-lts-x86/x.x.x"

  component {
    component_arn = aws_imagebuilder_component.falcon_sensor.arn
    parameter {
      name  = "FalconRpmUrl"
      value = "https://your-falcon-repo.com/falcon-sensor.rpm"
    }
    parameter {
      name  = "FalconDebUrl"
      value = "https://your-falcon-repo.com/falcon-sensor.deb"
    }
    parameter {
      name  = "CustomerId"
      value = "your-actual-customer-id"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.cloudwatch_agent.arn
    parameter {
      name  = "ConfigS3Path"
      value = "s3://your-bucket/cloudwatch-agent-config-ubuntu2024.json"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.python.arn
    parameter {
      name  = "AdditionalPackages"
      value = "boto3 awscli flask"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.nodejs.arn
    parameter {
      name  = "NvmVersion"
      value = "v0.39.1"
    }
    parameter {
      name  = "NodeVersion"
      value = "--lts"
    }
    parameter {
      name  = "GlobalPackages"
      value = "yarn gulp"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.aws_cli.arn
    parameter {
      name  = "AwsCliVersion"
      value = "latest"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.terraform_tflint.arn
    parameter {
      name  = "TerraformVersion"
      value = "1.5.0"
    }
    parameter {
      name  = "TflintVersion"
      value = "v0.47.0"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.systemd_timesyncd.arn
    parameter {
      name  = "NtpServers"
      value = "0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.prometheus_exporters.arn
    parameter {
      name  = "NodeExporterVersion"
      value = "1.6.1"
    }
    parameter {
      name  = "AdditionalExporters"
      value = ""
    }
  }

  component {
    component_arn = aws_imagebuilder_component.splunk_indexer.arn
    parameter {
      name  = "SplunkInstallerUrl"
      value = "https://download.splunk.com/products/splunk/releases/9.1.0/linux/splunk-9.1.0-9e907cedecb1_amd64.deb"
    }
    parameter {
      name  = "AdminPassword"
      value = "your-splunk-password"
    }
  }

  tags = {
    Project = "GoldenImageBuilder"
  }
} 
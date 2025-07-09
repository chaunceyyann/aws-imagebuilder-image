resource "aws_imagebuilder_image_recipe" "windows_server_2022" {
  name         = "WindowsServer2022Recipe"
  description  = "Recipe for Windows Server 2022 with Falcon Sensor, Python, Node.js, CloudWatch Agent, AWS CLI, Terraform, Prometheus Exporters, and Splunk Indexer"
  version      = "1.0.0"
  parent_image = "arn:aws:imagebuilder:us-east-1:aws:image/windows-server-2022-english-full-base-x86/x.x.x"

  component {
    component_arn = aws_imagebuilder_component.falcon_sensor_windows.arn
    parameter {
      name  = "FalconWindowsInstallerUrl"
      value = "https://your-falcon-repo.com/falcon-sensor-windows.exe"
    }
    parameter {
      name  = "CustomerId"
      value = "your-actual-customer-id"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.cloudwatch_agent_windows.arn
    parameter {
      name  = "ConfigS3Path"
      value = "s3://your-bucket/cloudwatch-agent-config-windows2022.json"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.python_windows.arn
    parameter {
      name  = "PythonVersionUrl"
      value = "https://www.python.org/ftp/python/3.11.4/python-3.11.4-amd64.exe"
    }
    parameter {
      name  = "AdditionalPackages"
      value = "boto3 awscli pandas"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.nodejs_windows.arn
    parameter {
      name  = "NodeInstallerUrl"
      value = "https://nodejs.org/dist/latest-v18.x/node-v18.17.1-x64.msi"
    }
    parameter {
      name  = "GlobalPackages"
      value = "yarn gulp"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.aws_cli_windows.arn
    parameter {
      name  = "AwsCliInstallerUrl"
      value = "https://awscli.amazonaws.com/AWSCLIV2.msi"
    }
  }

  component {
    component_arn = aws_imagebuilder_component.terraform_tflint_windows.arn
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
    component_arn = aws_imagebuilder_component.prometheus_exporters_windows.arn
    parameter {
      name  = "WindowsExporterVersion"
      value = "0.22.0"
    }
    parameter {
      name  = "AdditionalExporters"
      value = ""
    }
  }

  component {
    component_arn = aws_imagebuilder_component.splunk_indexer_windows.arn
    parameter {
      name  = "SplunkInstallerUrl"
      value = "https://download.splunk.com/products/splunk/releases/9.1.0/windows/splunk-9.1.0-9e907cedecb1-x64-release.msi"
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
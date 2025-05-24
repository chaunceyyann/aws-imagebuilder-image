resource "aws_imagebuilder_component" "falcon_sensor_windows" {
  name        = "FalconSensorComponentWindows"
  description = "Installs CrowdStrike Falcon Sensor on Windows Server 2022 - POC Placeholder"
  platform    = "Windows"
  version     = "1.0.0"
  data        = <<EOF
name: FalconSensorComponentWindows
description: Installs CrowdStrike Falcon Sensor on Windows Server 2022 - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallFalconSensor
        action: ExecutePowerShell
        inputs:
          commands:
            - Write-Output "POC: Skipping Falcon Sensor installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_imagebuilder_component" "cloudwatch_agent_windows" {
  name        = "CloudWatchAgentComponentWindows"
  description = "Installs and configures AWS CloudWatch Agent on Windows Server 2022 - POC Placeholder"
  platform    = "Windows"
  version     = "1.0.0"
  data        = <<EOF
name: CloudWatchAgentComponentWindows
description: Installs and configures AWS CloudWatch Agent on Windows Server 2022 - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallCloudWatchAgent
        action: ExecutePowerShell
        inputs:
          commands:
            - Write-Output "POC: Skipping CloudWatch Agent installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_imagebuilder_component" "python_windows" {
  name        = "PythonComponentWindows"
  description = "Installs Python on Windows Server 2022 - POC Placeholder"
  platform    = "Windows"
  version     = "1.0.0"
  data        = <<EOF
name: PythonComponentWindows
description: Installs Python on Windows Server 2022 - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallPython
        action: ExecutePowerShell
        inputs:
          commands:
            - Write-Output "POC: Skipping Python installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_imagebuilder_component" "nodejs_windows" {
  name        = "NodeJSComponentWindows"
  description = "Installs Node.js on Windows Server 2022 - POC Placeholder"
  platform    = "Windows"
  version     = "1.0.0"
  data        = <<EOF
name: NodeJSComponentWindows
description: Installs Node.js on Windows Server 2022 - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallNodeJS
        action: ExecutePowerShell
        inputs:
          commands:
            - Write-Output "POC: Skipping Node.js installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_imagebuilder_component" "aws_cli_windows" {
  name        = "AwsCliComponentWindows"
  description = "Installs AWS CLI on Windows Server 2022 - POC Placeholder"
  platform    = "Windows"
  version     = "1.0.0"
  data        = <<EOF
name: AwsCliComponentWindows
description: Installs AWS CLI on Windows Server 2022 - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallAwsCli
        action: ExecutePowerShell
        inputs:
          commands:
            - Write-Output "POC: Skipping AWS CLI installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_imagebuilder_component" "terraform_tflint_windows" {
  name        = "TerraformTflintComponentWindows"
  description = "Installs Terraform and TFLint on Windows Server 2022 - POC Placeholder"
  platform    = "Windows"
  version     = "1.0.0"
  data        = <<EOF
name: TerraformTflintComponentWindows
description: Installs Terraform and TFLint on Windows Server 2022 - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallTerraformTflint
        action: ExecutePowerShell
        inputs:
          commands:
            - Write-Output "POC: Skipping Terraform and TFLint installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_imagebuilder_component" "prometheus_exporters_windows" {
  name        = "PrometheusExportersComponentWindows"
  description = "Installs Prometheus Exporters on Windows Server 2022 - POC Placeholder"
  platform    = "Windows"
  version     = "1.0.0"
  data        = <<EOF
name: PrometheusExportersComponentWindows
description: Installs Prometheus Exporters on Windows Server 2022 - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallPrometheusExporters
        action: ExecutePowerShell
        inputs:
          commands:
            - Write-Output "POC: Skipping Prometheus Exporters installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "StreamlinedImageCreation"
  }
}

resource "aws_imagebuilder_component" "splunk_indexer_windows" {
  name        = "SplunkIndexerComponentWindows"
  description = "Installs Splunk Indexer on Windows Server 2022 - POC Placeholder"
  platform    = "Windows"
  version     = "1.0.0"
  data        = <<EOF
name: SplunkIndexerComponentWindows
description: Installs Splunk Indexer on Windows Server 2022 - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallSplunkIndexer
        action: ExecutePowerShell
        inputs:
          commands:
            - Write-Output "POC: Skipping Splunk Indexer installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "StreamlinedImageCreation"
  }
} 
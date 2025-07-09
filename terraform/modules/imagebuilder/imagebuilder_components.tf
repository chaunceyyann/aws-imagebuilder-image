resource "aws_imagebuilder_component" "falcon_sensor" {
  name        = "FalconSensorComponentLinux"
  description = "Installs CrowdStrike Falcon Sensor on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: FalconSensorComponentLinux
description: Installs CrowdStrike Falcon Sensor on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallFalconSensor
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping Falcon Sensor installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_component" "cloudwatch_agent" {
  name        = "CloudWatchAgentComponentLinux"
  description = "Installs and configures AWS CloudWatch Agent on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: CloudWatchAgentComponentLinux
description: Installs and configures AWS CloudWatch Agent on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallCloudWatchAgent
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping CloudWatch Agent installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_component" "python" {
  name        = "PythonComponentLinux"
  description = "Installs Python and pip on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: PythonComponentLinux
description: Installs Python and pip on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallPython
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping Python installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_component" "nodejs" {
  name        = "NodeJSComponentLinux"
  description = "Installs Node.js and npm on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: NodeJSComponentLinux
description: Installs Node.js and npm on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallNodeJS
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping Node.js installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_component" "aws_cli" {
  name        = "AwsCliComponentLinux"
  description = "Installs AWS CLI on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: AwsCliComponentLinux
description: Installs AWS CLI on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallAwsCli
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping AWS CLI installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_component" "terraform_tflint" {
  name        = "TerraformTflintComponentLinux"
  description = "Installs Terraform and TFLint on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: TerraformTflintComponentLinux
description: Installs Terraform and TFLint on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallTerraformTflint
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping Terraform and TFLint installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_component" "systemd_timesyncd" {
  name        = "SystemdTimesyncdComponentLinux"
  description = "Configures systemd-timesyncd for NTP on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: SystemdTimesyncdComponentLinux
description: Configures systemd-timesyncd for NTP on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: ConfigureSystemdTimesyncd
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping systemd-timesyncd configuration due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_component" "prometheus_exporters" {
  name        = "PrometheusExportersComponentLinux"
  description = "Installs Prometheus Exporters on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: PrometheusExportersComponentLinux
description: Installs Prometheus Exporters on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallPrometheusExporters
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping Prometheus Exporters installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
}

resource "aws_imagebuilder_component" "splunk_indexer" {
  name        = "SplunkIndexerComponentLinux"
  description = "Installs Splunk Indexer on Linux - POC Placeholder"
  platform    = "Linux"
  version     = "1.0.0"
  data        = <<EOF
name: SplunkIndexerComponentLinux
description: Installs Splunk Indexer on Linux - POC Placeholder
schemaVersion: 1.0

phases:
  - name: build
    steps:
      - name: InstallSplunkIndexer
        action: ExecuteBash
        inputs:
          commands:
            - echo "POC: Skipping Splunk Indexer installation due to placeholder values."
            - exit 0
EOF

  tags = {
    Project = "GoldenImageBuilder"
  }
} 
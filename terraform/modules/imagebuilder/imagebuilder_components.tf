locals {
  # Get all Linux component YAML files (excluding Windows ones)
  linux_component_files = fileset("${path.module}/../../../image_specs/golden_image_spec/component_specifications", "*-component.yaml")
  # Filter out Windows components
  linux_components = [for file in local.linux_component_files : file if !can(regex(".*-windows\\.yaml$", file))]
}

resource "aws_imagebuilder_component" "linux_components" {
  for_each = toset(local.linux_components)
  
  name        = replace(basename(each.key), ".yaml", "")
  description = "Component from ${each.key}"
  platform    = "Linux"
  version     = "1.0.0"
  data        = file("${path.module}/../../../image_specs/golden_image_spec/component_specifications/${each.key}")
  
  tags = {
    Project = "GoldenImageBuilder"
  }
} 
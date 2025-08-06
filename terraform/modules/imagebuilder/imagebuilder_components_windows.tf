locals {
  # Get all Windows component YAML files
  windows_component_files = fileset("${path.module}/../../../image_specs/golden_image_spec/component_specifications", "*-component-windows.yaml")
}

resource "aws_imagebuilder_component" "windows_components" {
  for_each = toset(local.windows_component_files)

  name        = replace(basename(each.key), ".yaml", "")
  description = "Windows component from ${each.key}"
  platform    = "Windows"
  version     = "1.0.0"
  data        = file("${path.module}/../../../image_specs/golden_image_spec/component_specifications/${each.key}")

  tags = {
    Project = "GoldenImageBuilder"
  }
}

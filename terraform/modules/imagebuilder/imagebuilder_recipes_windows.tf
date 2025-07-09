locals {
  # Get Windows recipe YAML file
  windows_recipe_files = fileset("${path.module}/../../../image_specs/golden_image_spec/image_specifications", "*windows*-recipe.yaml")
  
  # Create a mapping of component names to ARNs for Windows components
  # The for_each key is the filename, but we need to map by the component name
  windows_component_arns = {
    for filename, component in aws_imagebuilder_component.windows_components : 
    replace(basename(filename), ".yaml", "") => component.arn
  }
  
  # Load all Windows recipe YAML files once
  windows_recipe_data = {
    for file in local.windows_recipe_files : file => yamldecode(file("${path.module}/../../../image_specs/golden_image_spec/image_specifications/${file}"))
  }
}

resource "aws_imagebuilder_image_recipe" "windows_recipes" {
  for_each = local.windows_recipe_data
  
  name         = each.value["name"]
  description  = each.value["description"]
  version      = each.value["version"]
  parent_image = each.value["parentImage"]
  
  # Map components from YAML to actual component ARNs
  dynamic "component" {
    for_each = each.value["components"]
    
    content {
      # The componentArn now contains the simple component name, use it directly
      component_arn = local.windows_component_arns[component.value["componentArn"]]
      
      dynamic "parameter" {
        for_each = component.value["parameters"]
        content {
          name  = parameter.value["name"]
          value = parameter.value["value"]
        }
      }
    }
  }
  
  # Explicit dependency on Windows components
  depends_on = [aws_imagebuilder_component.windows_components]
  
  tags = {
    Project = "GoldenImageBuilder"
  }
} 
locals {
  # Get all Linux recipe YAML files
  linux_recipe_files = fileset("${path.module}/../../../image_specs/golden_image_spec/image_specifications", "*-recipe.yaml")
  # Filter out Windows recipes
  linux_recipes = [for file in local.linux_recipe_files : file if !can(regex(".*windows.*", file))]
  
  # Create a mapping of component names to ARNs for Linux components
  linux_component_arns = {
    for name, component in aws_imagebuilder_component.linux_components : 
    name => component.arn
  }
  
  # Load all Linux recipe YAML files once
  linux_recipe_data = {
    for file in local.linux_recipes : file => yamldecode(file("${path.module}/../../../image_specs/golden_image_spec/image_specifications/${file}"))
  }
}

resource "aws_imagebuilder_image_recipe" "linux_recipes" {
  for_each = local.linux_recipe_data
  
  name         = each.value["name"]
  description  = each.value["description"]
  version      = each.value["version"]
  parent_image = each.value["parentImage"]
  
  # Map components from YAML to actual component ARNs
  dynamic "component" {
    for_each = each.value["components"]
    
    content {
      # The componentArn now contains the simple component name, use it directly
      component_arn = local.linux_component_arns[component.value["componentArn"]]
      
      dynamic "parameter" {
        for_each = component.value["parameters"]
        content {
          name  = parameter.value["name"]
          value = parameter.value["value"]
        }
      }
    }
  }
  
  tags = {
    Project = "GoldenImageBuilder"
  }
} 
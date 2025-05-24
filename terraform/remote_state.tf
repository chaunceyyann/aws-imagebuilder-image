# Fetch the Terraform state from another project to use its outputs
data "terraform_remote_state" "other_project" {
  backend = "s3"
  config = {
    bucket = "docker-image-4codebuild-tfstate"
    key    = "terraform.tfstate"  # Using a different key for the other project's state file to avoid conflict
    region = "us-east-1"
  }
}

# Example: Output a value from the other project's state to verify access
output "other_project_example_output" {
  value = data.terraform_remote_state.other_project.outputs.example_output  # Replace 'example_output' with an actual output name from the other project's state
  description = "Example output from the other project's Terraform state"
}

# Use outputs from the other project in your resources if needed
# For example, if the other project outputs a VPC ID:
# resource "some_resource" "example" {
#   vpc_id = data.terraform_remote_state.other_project.outputs.vpc_id
#   ...
# } 
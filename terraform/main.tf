terraform {
  backend "s3" {
    bucket       = "golden-imagebuilder-tfstate"
    key          = "golden-imagebuilder/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

module "s3" {
  source = "./modules/s3"

  image_specs_bucket_name = "golden-imagebuilder-image-specs"

  common_tags = {
    Project = "GoldenImageBuilder"
    Environment = "Production"
    ManagedBy = "Terraform"
  }
}

module "imagebuilder" {
  source  = "./modules/imagebuilder"
  project = "GoldenImageBuilder"
  region  = "us-east-1"

  depends_on = [module.s3]
}

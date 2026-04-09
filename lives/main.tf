# live/main.tf — the calling root configuration
provider "aws" {
  alias  = "primary"
  region = "eu-central-1"
}

provider "aws" {
  alias  = "replica"
  region = "eu-west-1"
}

module "multi_region_app" {
  source   = "../modules/multi-region-app"
  app_name = var.app_name
  environment = var.environment

  providers = {
    aws.primary = aws.primary
    aws.replica = aws.replica
  }
}
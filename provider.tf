provider "aws" {
  region = var.aws_region
  shared_credentials_file = var.aws_credentials
  profile = "media"
}

data "aws_availability_zones" "all" {}
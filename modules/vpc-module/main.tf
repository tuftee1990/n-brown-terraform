terraform {
  backend "s3" {
  }
}

locals {
  resource_name_prefix = "var.environment-var.project-var.usage"
  component            = "network"
}

module "vpc_label" {
  source         = "../label-module"
  environment    = var.environment
  project        = var.project
  category       = var.category
  component      = "network"
  name_separator = "-"

  extra_tags = {
    "created-by" = "n-brown-terraform"
  }
}

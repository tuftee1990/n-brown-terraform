module "vpc_label" {
  source         = "../label-module"
  environment    = var.environment
  project        = var.project
  category       = var.category
  usage          = var.usage
  component      = "network"
  name_separator = "-"

  extra_tags = {
    "created-by" = "n-brown-terraform"
  }
}

module "infra_label" {
  source         = "../label-module"
  environment    = var.environment
  project        = var.project
  category       = var.category
  usage          = var.usage
  component      = "infrastructure"
  name_separator = "-"

  extra_tags = {
    "created-by" = "n-brown-terraform"
  }
}

module "vpc_1" {
  source = "../../modules/vpc-module"

  environment                = var.environment
  category                   = var.category
  project                    = var.project
  usage                      = ""
  cidr_block                 = "10.190.0.0/21"
  allowed_availability_zones = var.allowed_availability_zones
  domain_name_servers        = var.domain_name_servers
}

module "infra_1" {
  source = "../../modules/infrastructure-module"

  depends_on = [module.vpc_1]

  environment                = var.environment
  category                   = var.category
  project                    = var.project
  usage                      = ""
  allowed_availability_zones = var.allowed_availability_zones
}

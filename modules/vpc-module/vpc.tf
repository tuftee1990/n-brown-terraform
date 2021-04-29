resource "aws_vpc" "nb_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-vpc"
    }
  )
}

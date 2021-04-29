resource "aws_subnet" "nb_subnet_a" {
  cidr_block        = cidrsubnet(var.cidr_block, 3, 0)
  vpc_id            = aws_vpc.nb_vpc.id
  availability_zone = var.allowed_availability_zones[0]

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-subnet-${substr(var.allowed_availability_zones[0], -1, 1)}"
    },
  )
}

resource "aws_subnet" "nb_subnet_b" {
  cidr_block        = cidrsubnet(var.cidr_block, 3, 1)
  vpc_id            = aws_vpc.nb_vpc.id
  availability_zone = var.allowed_availability_zones[1]

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-subnet-${substr(var.allowed_availability_zones[1], -1, 1)}"
    },
  )
}

resource "aws_subnet" "nb_subnet_c" {
  cidr_block        = cidrsubnet(var.cidr_block, 3, 2)
  vpc_id            = aws_vpc.nb_vpc.id
  availability_zone = var.allowed_availability_zones[2]

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-subnet-${substr(var.allowed_availability_zones[2], -1, 1)}"
    },
  )
}

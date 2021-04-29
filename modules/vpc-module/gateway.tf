resource "aws_internet_gateway" "nb_gw" {
  vpc_id = aws_vpc.nb_vpc.id

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-internet-gateway"
    },
  )
}

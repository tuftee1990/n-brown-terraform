resource "aws_vpc_dhcp_options" "nb_vpc" {
  domain_name         = "eu-west-1.compute.internal"
  domain_name_servers = var.domain_name_servers

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-dhcpopts"
    },
  )
}

resource "aws_vpc_dhcp_options_association" "dhcp_vpc" {
  vpc_id          = aws_vpc.nb_vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.nb_vpc.id
}

resource "aws_network_acl" "nb_network_acl" {
  vpc_id = aws_vpc.nb_vpc.id
  subnet_ids = [
    aws_subnet.nb_subnet_a.id,
    aws_subnet.nb_subnet_b.id,
  aws_subnet.nb_subnet_c.id]

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-nacl"
  })
}

//Egress Rules

resource "aws_network_acl_rule" "nb_network_acl_rule_egress_self" {
  network_acl_id = aws_network_acl.nb_network_acl.id
  egress         = true
  protocol       = "-1"
  rule_number    = 100
  rule_action    = "allow"
  cidr_block     = aws_vpc.nb_vpc.cidr_block
}

resource "aws_network_acl_rule" "nb_network_acl_rule_egress_lb_listerner" {
  network_acl_id = aws_network_acl.nb_network_acl.id
  egress         = true
  protocol       = "tcp"
  rule_number    = 200
  rule_action    = "allow"
  from_port      = "443"
  to_port        = "443"
  cidr_block     = "0.0.0.0/0"
}

//Ingress Rules

resource "aws_network_acl_rule" "nb_network_acl_rule_ingress_self" {
  network_acl_id = aws_network_acl.nb_network_acl.id
  egress         = false
  protocol       = "-1"
  rule_number    = 100
  rule_action    = "allow"
  cidr_block     = aws_vpc.nb_vpc.cidr_block
}

resource "aws_network_acl_rule" "nb_network_acl_rule_ingress_lb_listerner" {
  network_acl_id = aws_network_acl.nb_network_acl.id
  egress         = false
  protocol       = "tcp"
  rule_number    = 200
  rule_action    = "allow"
  from_port      = "443"
  to_port        = "443"
  cidr_block     = "0.0.0.0/0"
}

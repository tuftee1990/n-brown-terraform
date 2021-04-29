locals {
  protocols = {
    "all"  = "-1"
    "icmp" = "1"
    "tcp"  = "6"
    "udp"  = "17"
  }

  ports_from = {
    "ssh"               = "22"
    "smtp"              = "25"
    "dns"               = "53"
    "http"              = "80"
    "krb"               = "88"
    "ntp"               = "123"
    "dce"               = "135"
    "netbios-names"     = "137"
    "netbios-sessions"  = "138"
    "netbios-datagrams" = "139"
    "snmp"              = "161"
    "snmp-trap"         = "162"
    "ldap"              = "389"
    "https"             = "443"
    "smb"               = "445"
    "kpasswd"           = "464"
    "syslog"            = "514"
    "ldaps"             = "636"
    "oracle"            = "1521"
    "nfs"               = "2049"
    "squid"             = "3401"
    "msft"              = "3268"
    "rdp"               = "3389"
    "hkp"               = "11371"
    "relpsyslog"        = "20514"
    "ephemeral"         = "32768"
  }

  ports_to = {
    "ssh"               = "22"
    "smtp"              = "25"
    "dns"               = "53"
    "http"              = "80"
    "krb"               = "88"
    "ntp"               = "123"
    "dce"               = "135"
    "netbios-names"     = "137"
    "netbios-sessions"  = "138"
    "netbios-datagrams" = "139"
    "snmp"              = "161"
    "snmp-trap"         = "162"
    "ldap"              = "389"
    "https"             = "443"
    "smb"               = "445"
    "kpasswd"           = "464"
    "syslog"            = "514"
    "ldaps"             = "636"
    "oracle"            = "1521"
    "nfs"               = "2049"
    "squid"             = "3401"
    "msft"              = "3269"
    "rdp"               = "3389"
    "hkp"               = "11371"
    "relpsyslog"        = "20514"
    "ephemeral"         = "65535"
  }
}


resource "aws_security_group" "common" {
  name   = "${module.vpc_label.name}-common-secgroup"
  vpc_id = aws_vpc.nb_vpc.id

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-common-secgroup"
      "sg"   = "base"
    },
  )
}

resource "aws_security_group_rule" "aws_nb_self_egress_all" {
  from_port         = 0
  protocol          = "ALL"
  security_group_id = aws_security_group.common.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["127.0.0.1/32"]
}

resource "aws_security_group_rule" "aws_nb_self_ingress_health_check" {
  from_port                = 0
  protocol                 = "ALL"
  security_group_id        = aws_security_group.common.id
  to_port                  = 0
  type                     = "egress"
  source_security_group_id = aws_security_group.common.id
}

resource "aws_security_group_rule" "aws_nb_self_ingress_all" {
  from_port         = 0
  protocol          = "ALL"
  security_group_id = aws_security_group.common.id
  to_port           = 0
  type              = "ingress"
  cidr_blocks       = ["127.0.0.1/32"]
}

resource "aws_security_group_rule" "aws_nb_self_egress_health_check" {
  from_port                = 0
  protocol                 = "ALL"
  security_group_id        = aws_security_group.common.id
  to_port                  = 0
  type                     = "ingress"
  source_security_group_id = aws_security_group.common.id
}

resource "aws_security_group" "aws_api" {
  name   = "${module.vpc_label.name}-aws-api-secgroup"
  vpc_id = aws_vpc.nb_vpc.id

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-api-secgroup"
      "sg"   = "aws_api"
    },
  )
}

resource "aws_security_group" "services" {
  name   = "${module.vpc_label.name}-service-secgroup"
  vpc_id = aws_vpc.nb_vpc.id

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-service-secgroup"
      "sg"   = "services"
    },
  )
}

resource "aws_security_group_rule" "aws_nb_lb_listerner_egress_all" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.services.id
  to_port           = 443
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "aws_nb_lb_listerner_ingress_all" {
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.services.id
  to_port           = 443
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "support" {
  name   = "${module.vpc_label.name}-support-secgroup"
  vpc_id = aws_vpc.nb_vpc.id

  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-support-secgroup"
      "sg"   = "support"
    },
  )
}

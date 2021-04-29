resource "aws_lb" "nb_app_lb" {
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    data.aws_security_group.nb_common.id,
    data.aws_security_group.nb_aws_api.id,
    data.aws_security_group.nb_services.id,
    data.aws_security_group.nb_support.id
  ]
  subnets = [
    data.aws_subnet.nb_subnet_a.id,
    data.aws_subnet.nb_subnet_b.id,
    data.aws_subnet.nb_subnet_c.id,
  ]

  enable_deletion_protection = true

  access_logs {
    bucket  = data.aws_s3_bucket.nb_elb_logs_s3.bucket
    prefix  = "nb_lb_logs"
    enabled = true
  }

  tags = merge(
    module.infra_label.tags,
    {
      "Name" = "${module.infra_label.name}-application-load-balancer"
    }
  )
}

resource "aws_lb_target_group" "nb_app_target_group" {
  port     = 443
  protocol = "HTTPS"
  vpc_id   = data.aws_vpc.vpc_1.id

  tags = merge(
    module.infra_label.tags,
    {
      "Name" = "${module.infra_label.name}-app-listener"
    }
  )
}

resource "aws_lb_listener" "nb_app_listener" {
  load_balancer_arn = aws_lb.nb_app_lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.nb_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nb_app_target_group.arn
  }
}

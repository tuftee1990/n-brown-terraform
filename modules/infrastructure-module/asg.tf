data "aws_ami" "nb_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}


resource "aws_launch_template" "nb_launch_template" {
  image_id      = data.aws_ami.nb_ami.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [
    data.aws_security_group.nb_common.id,
    data.aws_security_group.nb_support.id,
    data.aws_security_group.nb_services.id,
    data.aws_security_group.nb_aws_api.id
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    module.infra_label.tags,
    {
      "Name" = "${module.infra_label.name}-launch-template"
    }
  )
}

resource "aws_autoscaling_group" "nb_lb_asg" {
  vpc_zone_identifier = [
    data.aws_subnet.nb_subnet_a.id,
    data.aws_subnet.nb_subnet_b.id,
  data.aws_subnet.nb_subnet_c.id]
  desired_capacity          = 3
  max_size                  = 3
  min_size                  = 3
  health_check_grace_period = 300
  health_check_type         = "EC2"
  target_group_arns         = [aws_lb_target_group.nb_app_target_group.arn]

  launch_template {
    id      = aws_launch_template.nb_launch_template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "nb_lb_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.nb_lb_asg.id
  alb_target_group_arn   = aws_lb_target_group.nb_app_target_group.arn
}

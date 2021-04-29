#VPC FlowLogs

data "aws_iam_policy_document" "flow_logs" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "flow_log" {
  name               = module.vpc_label.name
  assume_role_policy = data.aws_iam_policy_document.flow_logs.json
}

data "aws_iam_policy_document" "flow_logs_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_policy" "flow_logs_policy_role_document" {
  name   = "${module.vpc_label.name}-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.flow_logs_policy_document.json
}

resource "aws_iam_policy_attachment" "flow_logs_role_policy_attachment" {
  name       = "${module.vpc_label.name}-policy-attachment"
  roles      = [aws_iam_role.flow_log.name]
  policy_arn = aws_iam_policy.flow_logs_policy_role_document.arn
}

resource "aws_cloudwatch_log_group" "flow_group" {
  name = "${module.vpc_label.name}-loggrp"
}

resource "aws_flow_log" "dcf_vpc" {
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.flow_group.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.nb_vpc.id
}

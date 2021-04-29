data "aws_vpc" "vpc_1" {
  filter {
    name   = "tag:Name"
    values = ["${module.vpc_label.name}-vpc"]
  }
}

data "aws_subnet" "nb_subnet_a" {
  vpc_id = data.aws_vpc.vpc_1.id
  tags = {
    Name = "${module.vpc_label.name}-subnet-${substr(var.allowed_availability_zones[0], -1, 1)}"
  }
}

data "aws_subnet" "nb_subnet_b" {
  vpc_id = data.aws_vpc.vpc_1.id
  tags = {
    Name = "${module.vpc_label.name}-subnet-${substr(var.allowed_availability_zones[1], -1, 1)}"
  }
}

data "aws_subnet" "nb_subnet_c" {
  vpc_id = data.aws_vpc.vpc_1.id
  tags = {
    Name = "${module.vpc_label.name}-subnet-${substr(var.allowed_availability_zones[2], -1, 1)}"
  }
}

data "aws_security_group" "nb_common" {
  vpc_id = data.aws_vpc.vpc_1.id
  name   = "${module.vpc_label.name}-common-secgroup"
}

data "aws_security_group" "nb_support" {
  vpc_id = data.aws_vpc.vpc_1.id
  name   = "${module.vpc_label.name}-support-secgroup"
}

data "aws_security_group" "nb_services" {
  vpc_id = data.aws_vpc.vpc_1.id
  name   = "${module.vpc_label.name}-service-secgroup"
}

data "aws_security_group" "nb_aws_api" {
  vpc_id = data.aws_vpc.vpc_1.id
  name   = "${module.vpc_label.name}-aws-api-secgroup"
}

data "aws_s3_bucket" "nb_elb_logs_s3" {
  bucket = "${module.vpc_label.name}-elb-logs-s3"
}

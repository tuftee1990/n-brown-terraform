resource "aws_kms_key" "nb_kms_key" {
  enable_key_rotation = true
  tags = merge(
    module.vpc_label.tags,
    {
      "Name" = "${module.vpc_label.name}-kms"
    },
  )
}

resource "aws_kms_alias" "nb_kms_key" {
  target_key_id = aws_kms_key.nb_kms_key.id
  name          = "alias/${module.vpc_label.name}-kms"
}

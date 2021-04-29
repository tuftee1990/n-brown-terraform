data "aws_caller_identity" "current" {}

locals {
  keys  = ["Environment", "Project", "Usage", "Category", "Component"]
  parts = ["${var.environment}", "${var.project}", "${var.usage}", "${var.category}", "${var.component}"]

  name = "${
    join(
      "${var.name_separator}",
      compact(local.parts)
    )
  }"

  generated_tags = "${zipmap(
    compact(list(
      var.environment != "" ? "Environment" : "",
      var.project != "" ? "Project" : "",
      var.usage != "" ? "Usage" : "",
      var.category != "" ? "Category" : "",
      "Account ID",
      var.component != "" ? "Component" : ""
    )),
    compact(list(
      var.environment,
      var.project,
      var.usage,
      var.category,
      data.aws_caller_identity.current.account_id,
      var.component
    ))
  )}"

  name_map = {
    Name = "${local.name}"
  }

  tags = "${merge(
    local.name_map,
    local.generated_tags,
    var.extra_tags
  )}"

  tags_as_list_of_maps = ["${data.null_data_source.tags_as_list_of_maps.*.outputs}"]
}

data "null_data_source" "tags_as_list_of_maps" {
  count = "${length(keys(local.tags))}"

  inputs = "${merge(
    map(
      "key", "${element(keys(local.tags), count.index)}",
      "value", "${element(values(local.tags), count.index)}"
    ),
    var.additional_tag_map
  )}"
}

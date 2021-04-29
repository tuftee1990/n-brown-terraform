output "environment" {
  value = "${var.environment}"
}

output "project" {
  value = "${var.project}"
}

output "component" {
  value = "${var.component}"
}

output "category" {
  value = "${var.category}"
}

output "usage" {
  value = "${var.usage}"
}

output "name" {
  value = "${local.name}"
}

output "tags" {
  value       = "${local.tags}"
  description = "Standardised map of tags"
}

output "tags_as_list_of_maps" {
  value       = "${local.tags_as_list_of_maps}"
  description = "Tags as a list of maps (to support autoscaling)"
}

variable "environment" {
  type        = "string"
  description = "The Environment ID"
}

variable "project" {
  type        = "string"
  description = "project code"
}

variable "usage" {
  default     = ""
  description = "environment usage label - optional. Used to subdivide an environments in to multiple copies"
}

variable "component" {
  default     = ""
  description = "Component Code"
}

variable "category" {
  default     = ""
  description = "Category Code"
}

variable "name_separator" {
  default     = "-"
  description = "The character(s) used to separate components of a name"
}

variable "extra_tags" {
  type        = "map"
  default     = {}
  description = "Additional tags to add."
}

variable "additional_tag_map" {
  type        = "map"
  default     = {}
  description = "Additional key/value pairs to add when creating tags as a list of maps (for autoscaling propagation)"
}

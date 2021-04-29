variable "environment" {
  type        = string
  description = "the current environment"
}

variable "project" {
  type        = string
  description = "the project code"
}

variable "usage" {
  type        = string
  description = "the environment subdivision"
}

variable "category" {
  type        = string
  description = "The enviromnent Category"
}

variable "allowed_availability_zones" {
  type        = list(string)
  description = "Allowed availability zones"
}

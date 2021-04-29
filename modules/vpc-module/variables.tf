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

variable "cidr_block" {
  type        = string
  description = "The CIDR range for the whole VPC"
}

variable "allowed_availability_zones" {
  type        = list(string)
  description = "Allowed availability zones"
}

variable "domain_name_servers" {
  type        = list(string)
  description = "association of dns servers to use within environment"
}

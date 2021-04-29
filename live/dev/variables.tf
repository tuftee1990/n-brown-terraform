
variable "environment" {
  type        = string
  description = "The runtime environment"
}

variable "project" {
  type        = string
  description = "The project code"
}

variable "category" {
  type = string
}

variable "allowed_availability_zones" {
  type        = list(string)
  description = "Allowed availability zones"
}

variable "domain_name_servers" {
  type        = list(string)
  description = "association of dns servers to use within environment"
}

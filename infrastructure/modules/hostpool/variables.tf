

variable "resource_group_name" {
  type = string
}

variable "host_pool_name" {
  type = string
}

variable "avdservice_region" {
  type    = string
  default = "eastus2"
}

variable "friendly_name" {
  type = string
}

variable "description" {
  type = string
}

variable "custom_rdp_properties" {
  type    = string
  default = null
}

variable "max_sessions" {
  type    = number
  default = 25
}

variable "host_pool_type" {
  type    = string
  default = "Pooled"
}

variable "load_balancer_type" {
  type    = string
  default = "BreadthFirst"
}

variable "validate_environment" {
  type    = bool
  default = false
}

variable "host_pools" {
  type = map(object({
    resource_group_name   = string
    friendly_name         = string
    description           = string
    avdservice_region     = optional(string)
    custom_rdp_properties = optional(string)
    max_sessions          = optional(number)
    host_pool_type        = optional(string)
    load_balancer_type    = optional(string)
    validate_environment  = optional(bool)
  }))
}

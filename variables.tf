variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the route table. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "name" {
  description = " (Required) The name of the route table. Changing this forces a new resource to be created."
  type        = string
}

variable "disable_bgp_route_propagation" {
  description = "(Optional) Boolean flag which controls propagation of routes learned by BGP on that route table. True means disable."
  type        = bool
  default     = false
}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = string
  }))
}

variable "subscription_id" {
  description = "(Required) Specifies Subscription ID."
  type        = string
}

variable "subnets_to_associate" {
  description = "(Optional) Specifies the subscription id, resource group name, and name of the subnets to associate"
  type        = list(string)
  default     = []
}

variable "virtual_network_name" {
  description = "(Reqired) Specifies the VNET name."
  type        = string
}

variable "virtual_network_resource_group_name" {
  description = "(Reqired) Specifies the VNET name."
  type        = string
}

variable "tags" {
  description = "A map of the tags to use on the resources that are deployed with this module."
  default     = {}
}

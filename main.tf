terraform {
  required_version = ">=0.14.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.36.0"
    }
  }
}

locals {
  module_tag = {
    "module" = basename(abspath(path.module))
  }
  tags = merge(var.tags, local.module_tag)
}

resource "azurerm_route_table" "this" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  lifecycle {
    ignore_changes = [
      tags,
      route
    ]
  }
}

resource "azurerm_route" "this" {
  for_each               = { for route in var.routes : route.name => route }
  name                   = each.key
  resource_group_name    = azurerm_route_table.this.resource_group_name
  route_table_name       = azurerm_route_table.this.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_in_ip_address
}

resource "azurerm_subnet_route_table_association" "this" {
  for_each       = toset(var.subnets_to_associate)
  subnet_id      = "/subscriptions/${var.subscription_id}/resourceGroups/${var.virtual_network_resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.virtual_network_name}/subnets/${each.key}"
  route_table_id = azurerm_route_table.this.id
}

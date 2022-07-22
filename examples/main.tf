resource "azurerm_resource_group" "this" {
  name     = uuid()
  location = "westeurope"
}

module "rt" {
  source                        = "./module"
  name                          = "rt-example"
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  disable_bgp_route_propagation = true
  routes = [
    {
      name                   = "default"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "Virtual Appliance"
      next_hop_in_ip_address = "192.168.255.1"
    }
  ]
  subnets_to_associate = {
    ("mySubneToAssociateName") = {
      subscription_id      = "myVnetToAssociateSubscriptionId"
      resource_group_name  = "myVnetToAssociateResourceGroupName"
      virtual_network_name = "myVnetToAssociateName"
    }
  }
}

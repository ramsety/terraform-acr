resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_container_registry" "acr" {
  name                     = local.container_registry_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Premium"
  admin_enabled            = false
  georeplication_locations = var.georeplicated_region_list

network_rule_set {
    default_action  = "Deny"
    virtual_network = local.allowed_virtual_networks
  }  
}
terraform {
backend "azurerm" {
    resource_group_name   = var.RG_NAME
    storage_account_name  = "tfstateac"
    container_name        = "tfstate"
    key                   = "BXNSxGxwugWitklqE6wOTSe2+PkxGPgNtriZrLgkY6tiwaCzkr/owQS8UUmfoZzSwLK2yJckMXMgXxz0P2qAEw=="
}
}
resource "azurerm_container_registry" "acr" {
  name                     = var.ACR_NAME
  resource_group_name      = var.RG_NAME
  location                 = "East US"
  sku                      = "Premium"
  admin_enabled            = false
  georeplication_locations = var.georeplicated_region_list

network_rule_set {
    default_action  = "Deny"
    virtual_network = local.allowed_virtual_networks
  }  
}

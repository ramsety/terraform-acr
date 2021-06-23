terraform {
backend "azurerm" {
    resource_group_name   = var.RG_NAME
    storage_account_name  = "tfstateac"
    container_name        = "tfstate"
    key                   = "BXNSxGxwugWitklqE6wOTSe2+PkxGPgNtriZrLgkY6tiwaCzkr/owQS8UUmfoZzSwLK2yJckMXMgXxz0P2qAEw=="
}
}
provider "azurerm" {
  version = ">=2.0"
  # The "feature" block is required for AzureRM provider 2.x.
  features {}
}
resource "azurerm_container_registry" "acr" {
  name                     = var.ACR_NAME
  resource_group_name      = "eval-rg"
  location                 = "East US"
  sku                      = "Premium"
  admin_enabled            = false
  georeplication_locations = ["West Europe"]

network_rule_set {
    default_action             = "Allow"
    ip_rules       = ["10.0.0.0/24", "10.1.0.0/24", "10.2.0.0/24"]
}
}

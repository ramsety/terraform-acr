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
    bypass                     = ["AzureServices"]
    virtual_network_subnet_ids = ["/subscriptions/8d499e57-3675-4d06-ae05-1fe9de2b0f16/resourceGroups/eval-rg/providers/Microsoft.Network/virtualNetworks/eval-vnet-01/subnets/subnet-01", "/subscriptions/8d499e57-3675-4d06-ae05-1fe9de2b0f16/resourceGroups/eval-rg/providers/Microsoft.Network/virtualNetworks/eval-vnet-01/subnets/subnet-02", "/subscriptions/8d499e57-3675-4d06-ae05-1fe9de2b0f16/resourceGroups/eval-rg/providers/Microsoft.Network/virtualNetworks/eval-vnet-01/subnets/subnet-03"]
}
}

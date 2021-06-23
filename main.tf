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

resource "azurerm_resource_group" "rg-evalrmsty001" {
  name     = "rg-evalrmsty001"
  location = "East US"
}

resource "azurerm_virtual_network" "rmsty01_vnet01" {
  name                = "rmsty01_vnet01"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-evalrmsty001.location
  resource_group_name = azurerm_resource_group.rg-evalrmsty001.name
}

resource "azurerm_subnet" "endpoint" {
  name                 = "endpoint"
  resource_group_name  = azurerm_resource_group.rg-evalrmsty001.name
  virtual_network_name = azurerm_virtual_network.rmsty01_vnet01.name
  address_prefix       = "10.0.2.0/24"

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_container_registry" "rmsty01acr" {
  name                     = "rmsty01acr"
  resource_group_name      = azurerm_resource_group.rg-evalrmsty001.name
  location                 = azurerm_resource_group.rg-evalrmsty001.location
  sku                      = "Premium"
  admin_enabled            = false
}

resource "azurerm_private_endpoint" "rmsty01_pe" {
  name                = "rmsty01_pe"
  location            = azurerm_resource_group.rg-evalrmsty001.location
  resource_group_name = azurerm_resource_group.rg-evalrmsty001.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "rmsty01acr-privateserviceconnection"
    private_connection_resource_id = azurerm_container_registry.rmsty01acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }
}

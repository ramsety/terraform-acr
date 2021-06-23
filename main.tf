resource "azurerm_resource_group" "rg_rmsty01" {
  name     = "rg_rmsty01"
  location = "East US"
}

resource "azurerm_virtual_network" "rmsty01_vnet" {
  name                = "rmsty01_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_rmsty01.location
  resource_group_name = azurerm_resource_group.rg_rmsty01.name
}

resource "azurerm_subnet" "endpoint" {
  name                 = "endpoint"
  resource_group_name  = azurerm_resource_group.rg_rmsty01.name
  virtual_network_name = azurerm_virtual_network.rmsty01_vnet.name
  address_prefix       = "10.0.2.0/24"

  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_container_registry" "rmsty01_acr" {
  name                     = "rmsty01_acr"
  resource_group_name      = azurerm_resource_group.rg_rmsty01.name
  location                 = azurerm_resource_group.rmsty01_vnet.location
  sku                      = "Premium"
  admin_enabled            = false
}

resource "azurerm_private_endpoint" "rmsty01_pe" {
  name                = "rmsty01_pe"
  location            = azurerm_resource_group.rg_rmsty01.location
  resource_group_name = azurerm_resource_group.rg_rmsty01.name
  subnet_id           = azurerm_subnet.endpoint.id

  private_service_connection {
    name                           = "rmsty01_acr-privateserviceconnection"
    private_connection_resource_id = azurerm_container_registry.rmsty01_acr.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }
}

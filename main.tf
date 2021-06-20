backend "azurerm" {
    resource_group_name   = var.RG_NAME
    storage_account_name  = "jonnychipztstate"
    container_name        = "tstate"
    key                   = "+uRmL73LSnXvSEGMG9pd26R28qvgFS9z3BcZrg+NHAExrs9HkRhOjNGWxT9c/J0iDcwF2t+txjCf0ZfDayV6pw=="
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

resource "azurerm_key_vault" "example" {
  name                        = "examplekeyvault"
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }

  network_rule_set {
    default_action  = "Deny"
    virtual_network = local.allowed_virtual_networks
  }  
}


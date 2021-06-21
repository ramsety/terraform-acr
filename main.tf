backend "azurerm" {
    resource_group_name   = var.RG_NAME
    storage_account_name  = "tfstateac"
    container_name        = "tfstate"
    key                   = "BXNSxGxwugWitklqE6wOTSe2+PkxGPgNtriZrLgkY6tiwaCzkr/owQS8UUmfoZzSwLK2yJckMXMgXxz0P2qAEw=="
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

resource "azurerm_key_vault" "example" {
  name                        = var.KV_NAME
  location                    = "East US"
  resource_group_name         = var.RG_NAME
  enabled_for_disk_encryption = true
  tenant_id                   = "70982e01-16e3-4267-9e23-83394bd1a9e8"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = "70982e01-16e3-4267-9e23-83394bd1a9e8"
    object_id = "f009dcdd-414d-4732-8c42-c4ab68934415"

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


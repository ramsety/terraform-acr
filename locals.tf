locals {
  environment_name        = var.environment_name
  resource_group_name     = "rg-test-${local.environment_name}-001"
  container_registry_name = var.container_registry_name
  location                = "eastus"
}

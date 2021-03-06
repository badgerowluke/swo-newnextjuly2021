data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "vault" {
    name                        = var.name
    location                    = var.location
    resource_group_name         = var.name
    enabled_for_disk_encryption = true
    tenant_id                   = data.azurerm_client_config.current.tenant_id
    purge_protection_enabled    = false

    sku_name = "standard"

    access_policy {
        tenant_id               = data.azurerm_client_config.current.tenant_id
        object_id               = data.azurerm_client_config.current.object_id


        secret_permissions          = [
                "get", "list", "set", "delete", "recover", "backup", "restore"
        ]
    }
}
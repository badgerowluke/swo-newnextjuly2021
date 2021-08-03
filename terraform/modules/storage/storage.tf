locals {
  administrator_password = base64decode(var.admin_password)
}

resource "azurerm_mssql_server" "sqldb_server" {
  name                          = var.name
  resource_group_name           = var.rg_name
  location                      = var.location
  version                       = "12.0"

  administrator_login           = var.admin_login 
  administrator_login_password  = var.admin_password
}

resource "azurerm_mssql_database" "sqldb" {
    name                        = var.dbname
    server_id                   = azurerm_mssql_server.sqldb_server.id
    sku_name                    = "BC_Gen5_2"

    
}

resource "azurerm_mssql_server_transparent_data_encryption" "encryption" {
  server_id = azurerm_mssql_server.sqldb_server.id
}
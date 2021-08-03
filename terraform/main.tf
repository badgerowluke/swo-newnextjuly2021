provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rm" {
  name     = "newhire2021"
  location = "northcentralus"
}

module "vault"  {
  source = "./modules/vault"
  name = "newhire2021"
  location = "northcentralus"
}

module "monitoring"  {
  source = "./modules/monitoring"
  name = "newhire2021"
  location = "northcentralus"
    rg_name = azurerm_resource_group.rm.name
}

module "persistece" {
  source = "./modules/storage"
  name = "newhire2021"
  location = "northcentralus"
  dbname = "db-newhire2021"
  rg_name = azurerm_resource_group.rm.name
}

module "app" {
  source = "./modules/app"
  name = "newhire2021"
  location = "northcentralus"  
  rg_name = azurerm_resource_group.rm.name
}
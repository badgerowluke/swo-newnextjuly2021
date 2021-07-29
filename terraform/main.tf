provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rm" {
  name     = "newhire2021"
  location = "northcentralus"
}
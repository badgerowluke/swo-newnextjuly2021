resource "azurerm_application_insights" "insights" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.rg_name
  application_type      = "web"
}

output "instrumentkey" {
    value = azurerm_application_insights.insights.instrumentation_key
}
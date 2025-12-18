resource "azurerm_resource_group" "this" {
  name     = "rg-moath-${var.environment}"
  location = var.location
}


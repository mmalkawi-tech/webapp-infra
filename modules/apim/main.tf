resource "azurerm_api_management" "this" {
  name                = "apim-moath-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email

  sku_name = "Consumption_0"

  tags = {
    owner       = "moath"
    environment = var.environment
  }
}

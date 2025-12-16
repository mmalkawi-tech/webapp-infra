resource "azurerm_service_plan" "this" {
  name                = "asp-ui-moath-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  os_type  = "Linux"
  sku_name = "B1"   # QUOTA-SAFE
}

resource "azurerm_linux_web_app" "this" {
  name                = "ui-moath-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    application_stack {
      node_version = var.node_version
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "REACT_APP_API_URL"        = ""   # Will be set later via pipeline (APIM URL)
  }

  tags = {
    owner       = "moath"
    environment = var.environment
  }
}

resource "azurerm_api_management" "this" {
  name                = "apim-moath-${var.environment}-v2"
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

resource "azurerm_api_management_backend" "aks" {
  name                = "aks-backend-${var.environment}"
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name
  protocol            = "http"
  url                 = var.aks_ingress_url
}

resource "azurerm_api_management_api" "backend_api" {
  name                = "backend-api-${var.environment}"
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.this.name
  revision            = "1"
  display_name        = "Backend API"
  path                = "api"
  protocols           = ["http", "https"]
  service_url         = var.aks_ingress_url
}

resource "azurerm_api_management_api_operation" "backend_a" {
  operation_id        = "backend-a-operation"
  api_name            = azurerm_api_management_api.backend_api.name
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.resource_group_name
  display_name        = "Backend A"
  method              = "POST"
  url_template        = "/a"
}

resource "azurerm_api_management_api_operation_policy" "backend_a_policy" {
  api_name            = azurerm_api_management_api.backend_api.name
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.resource_group_name
  operation_id        = azurerm_api_management_api_operation.backend_a.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <set-backend-service backend-id="${azurerm_api_management_backend.aks.name}" />
    <rewrite-uri template="/api/a" />
    <base />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
  <on-error>
    <base />
  </on-error>
</policies>
XML
}

resource "azurerm_api_management_api_operation" "backend_b" {
  operation_id        = "backend-b-operation"
  api_name            = azurerm_api_management_api.backend_api.name
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.resource_group_name
  display_name        = "Backend B"
  method              = "POST"
  url_template        = "/b"
}

resource "azurerm_api_management_api_operation_policy" "backend_b_policy" {
  api_name            = azurerm_api_management_api.backend_api.name
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.resource_group_name
  operation_id        = azurerm_api_management_api_operation.backend_b.operation_id

  xml_content = <<XML
<policies>
  <inbound>
    <set-backend-service backend-id="${azurerm_api_management_backend.aks.name}" />
    <rewrite-uri template="/api/b" />
    <base />
  </inbound>
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
  <on-error>
    <base />
  </on-error>
</policies>
XML
}

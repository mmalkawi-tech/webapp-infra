output "app_service_name" {
  value = azurerm_linux_web_app.this.name
}

output "app_service_url" {
  value = azurerm_linux_web_app.this.default_hostname
}

output "server_name" {
  value = azurerm_postgresql_flexible_server.this.name
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}

output "database_name" {
  value = azurerm_postgresql_flexible_server_database.this.name
}

output "admin_username" {
  value = var.admin_username
}

output "admin_password" {
  value     = var.admin_password
  sensitive = true
}

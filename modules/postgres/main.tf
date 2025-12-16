resource "azurerm_postgresql_flexible_server" "this" {
  name                   = "pg-moath-${var.environment}"
  resource_group_name    = var.resource_group_name
  location               = var.location

  administrator_login    = var.admin_username
  administrator_password = var.admin_password

  sku_name               = "B_Standard_B1ms"
  version                = "14"
  storage_mb             = 32768

  backup_retention_days  = 7
  zone                   = "1"

  delegated_subnet_id    = null
  private_dns_zone_id    = null

  public_network_access_enabled = true
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}

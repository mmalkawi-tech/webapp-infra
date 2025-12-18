
resource "azurerm_resource_group" "shared" {
  name     = "rg-moath-shared"
  location = "westus2"
}

module "acr" {
  source              = "../modules/acr"
  resource_group_name = azurerm_resource_group.shared.name
  location            = azurerm_resource_group.shared.location
}

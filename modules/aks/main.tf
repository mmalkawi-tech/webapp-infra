resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-moath-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aks-moath-${var.environment}"

  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_B2s"   # QUOTA-SAFE
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
  }

  # 👇 THIS is the important line
  acr_id = var.acr_id

  tags = {
    owner       = "moath"
    environment = var.environment
  }
}

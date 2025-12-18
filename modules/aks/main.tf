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


  tags = {
    owner       = "moath"
    environment = var.environment
  }
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}

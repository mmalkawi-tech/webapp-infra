data "terraform_remote_state" "shared" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate-moath"
    storage_account_name = "tfstatemoath001"
    container_name       = "tfstate"
    key                  = "shared/terraform.tfstate"
  }
}

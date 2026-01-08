module "resource_group" {
  source      = "../../modules/resource-group"
  environment = var.environment
  location    = var.location
}


module "postgres" {
  source              = "../../modules/postgres"
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.name

  admin_username = "pgadmin"
  admin_password = var.postgres_admin_password
  database_name  = "webappdb-moath-${var.environment}"
}


module "aks" {
  source              = "../../modules/aks"
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.name

  acr_id = data.terraform_remote_state.shared.outputs.acr_id
}


module "app_service" {
  source              = "../../modules/app-service"
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.name
}


module "apim" {
  source              = "../../modules/apim"
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.name

  publisher_name  = "Moath WebApp Prod"
  publisher_email = "moath@example.com"
  aks_ingress_url = "http://4.155.154.108"
}


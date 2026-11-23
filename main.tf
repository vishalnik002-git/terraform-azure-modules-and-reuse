# Root / Parent Module calling reusable child modules

# 1. Calling Reusable Resource Group Module
module "resource_group" {
  source   = "./modules/resource-group"
  name     = "rg-${var.environment}-modular-demo"
  location = var.location
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform-Modules"
  }
}

# 2. Calling Reusable Storage Account Module
# Consumes output from module.resource_group
module "storage_account" {
  source                   = "./modules/storage-account"
  name                     = var.storage_account_name
  resource_group_name      = module.resource_group.name
  location                 = module.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform-Modules"
  }
}

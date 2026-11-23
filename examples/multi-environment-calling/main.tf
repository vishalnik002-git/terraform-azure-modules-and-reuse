# Demonstration of calling the same reusable modules multiple times with different parameters

module "dev_rg" {
  source   = "../../modules/resource-group"
  name     = "rg-multicall-dev"
  location = "eastus"
  tags     = { Environment = "Dev" }
}

module "staging_rg" {
  source   = "../../modules/resource-group"
  name     = "rg-multicall-staging"
  location = "centralus"
  tags     = { Environment = "Staging" }
}

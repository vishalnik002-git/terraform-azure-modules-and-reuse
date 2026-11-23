output "id" {
  description = "The ID of the created Resource Group."
  value       = azurerm_resource_group.this.id
}

output "name" {
  description = "The Name of the created Resource Group."
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "The Location of the created Resource Group."
  value       = azurerm_resource_group.this.location
}

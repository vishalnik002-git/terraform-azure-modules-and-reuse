output "resource_group_name" {
  description = "Output forwarded from child resource-group module."
  value       = module.resource_group.name
}

output "storage_account_endpoint" {
  description = "Output forwarded from child storage-account module."
  value       = module.storage_account.primary_blob_endpoint
}

variable "name" {
  type        = string
  description = "The name of the storage account (lowercase alphanumeric, 3-24 characters)."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the parent resource group."
}

variable "location" {
  type        = string
  description = "The Azure location for the storage account."
}

variable "account_tier" {
  type        = string
  description = "Tier to use (Standard or Premium)."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Replication strategy (LRS, GRS, ZRS)."
  default     = "LRS"
}

variable "tags" {
  type        = map(string)
  description = "Tags to assign to the storage account."
  default     = {}
}

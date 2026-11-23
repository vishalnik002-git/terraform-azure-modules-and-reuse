variable "environment" {
  type        = string
  description = "Target deployment environment."
  default     = "dev"
}

variable "location" {
  type        = string
  description = "Azure region."
  default     = "eastus"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account."
  default     = "stmodulereusedev01"
}

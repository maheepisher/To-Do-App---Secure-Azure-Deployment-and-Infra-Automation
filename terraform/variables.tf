
variable "resource_group_name" {
  description = "Name for the resource group"
  type        = string
  default     = "rg-todo-final"
}

variable "location" {
  description = "Azure location"
  type        = string
  default     = "eastus"
}

variable "admin_username" {
  description = "Admin username for VM (demo)"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for VM (demo) - use secure method in production"
  type        = string
  default     = "P@ssw0rd1234!"
}

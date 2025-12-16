variable "environment" {
  description = "Environment name (dev, qa, prod)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "node_version" {
  description = "Node.js version for App Service"
  type        = string
  default     = "18-lts"
}

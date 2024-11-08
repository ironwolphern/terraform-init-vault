#------------------------------------------------------------------------------
# Variables (Input Variables)
#------------------------------------------------------------------------------
variable "vault_addr" {
  type        = string
  description = "Vault address (e.g. https://vault.example.com:8200)"
  nullable    = false
}

variable "vault_token" {
  type        = string
  description = "Vault token"
  nullable    = false
  validation {
    condition     = length(var.vault_token) > 0
    error_message = "Vault token must not be empty"
  }
}

variable "admin_password" {
  type        = string
  description = "Admin password"
  nullable    = false
  sensitive   = true
  validation {
    condition     = length(var.admin_password) > 0
    error_message = "Admin password must not be empty"
  }
}

variable "devops_password" {
  type        = string
  description = "Devops password"
  nullable    = false
  sensitive   = true
  validation {
    condition     = length(var.devops_password) > 0
    error_message = "Admin password must not be empty"
  }
}

variable "ip_whitelist" {
  type        = list(string)
  description = "IP whitelist"
  nullable    = true
}

variable "ssh_keys" {
  type        = map(string)
  description = "SSH keys (Name and public key)"
  nullable    = true
}

variable "pve_auth_keys_userpass" {
  type        = map(string)
  description = "Proxmox Authentication userpass (Username and password)"
  nullable    = true
}

variable "pve_auth_keys_api" {
  type        = map(string)
  description = "Proxmox Authentication api (Username and API token)"
  nullable    = true
}

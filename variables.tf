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

variable "auth_keys_user_password" {
  type        = map(string)
  description = "Authentication keys (Username and password)"
  nullable    = true
}

variable "auth_keys_user_api_token" {
  type        = map(string)
  description = "Authentication keys (Username and API token)"
  nullable    = true
}

# variable "vault_login_approle_role_id" {
#   type        = string
#   description = "Vault approle role id"
# }
#
# variable "vault_login_approle_secret_id" {
#   type        = string
#   description = "Vault approle secret id"
# }

#------------------------------------------------------------------------------
# Main Terraform configuration file
#------------------------------------------------------------------------------
resource "vault_policy" "admin" {
  name   = "admin"
  policy = file("${path.module}/admin-policy.hcl")
}

# Uncomment the following block to enable the Vault authentication method userpass
resource "vault_auth_backend" "userpass" {
  type = "userpass"
  path = "userpass"
}

resource "vault_generic_endpoint" "admin_user" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/admin"
  ignore_absent_fields = true

  data_json = jsonencode({
    policies  = [vault_policy.admin.name]
    password  = var.admin_password
    token_ttl = "1h"
  })
}

output "admin_username" {
  value = "admin"
}

output "admin_policy_name" {
  value = vault_policy.admin.name
}

resource "vault_policy" "kestra" {
  name   = "kestra"
  policy = file("${path.module}/kestra-policy.hcl")
}

# Uncomment the following block to enable the Vault AppRole authentication backend
resource "vault_auth_backend" "approle" {
  type = "approle"
  path = "approle"
}

resource "vault_approle_auth_backend_role" "kestra" {
  backend        = vault_auth_backend.approle.path
  role_name      = "kestra-role"
  token_policies = [vault_policy.kestra.name]

  # AppRole security configuration
  token_ttl             = 3600
  token_max_ttl         = 14400
  token_num_uses        = 0
  secret_id_ttl         = 600
  secret_id_num_uses    = 0
  bind_secret_id        = true
  secret_id_bound_cidrs = var.ip_whitelist
  token_bound_cidrs     = var.ip_whitelist
}

resource "vault_approle_auth_backend_role_secret_id" "kestra" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.kestra.role_name
}

output "role_id" {
  value     = vault_approle_auth_backend_role_id.kestra.role_id
  sensitive = false
}

output "secret_id" {
  value     = vault_approle_auth_backend_secret_id.kestra.secret_id
  sensitive = true
}

# Uncomment the following block to enable the Vault engine kv-v2
resource "vault_mount" "laboratory" {
  path        = "laboratory"
  type        = "kv"
  options     = { version = "2" }
  description = "Secret KV Version 2 secret engine mount"
}

resource "vault_kv_secret_v2" "ssh" {
  count = (var.ssh_keys != null) ? 1 : 0
  #mount               = vault_mount.laboratory.path
  mount               = "laboratory"
  name                = "ssh"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      for key, value in var.ssh_keys : key => value
    }
  )
  custom_metadata {
    max_versions = 5
  }
}

resource "vault_kv_secret_v2" "pve_auth_user_password" {
  count = (var.auth_keys_user_password != null) ? 1 : 0
  #mount               = vault_mount.laboratory.path
  mount               = "laboratory"
  name                = "proxmox/auth/user_password"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      for key, value in var.auth_keys_user_password : key => value
    }
  )
  custom_metadata {
    max_versions = 5
  }
}

resource "vault_kv_secret_v2" "pve_auth_user_api_token" {
  count = (var.auth_keys_user_api_token != null) ? 1 : 0
  #mount               = vault_mount.laboratory.path
  mount               = "laboratory"
  name                = "proxmox/auth/user_api_token"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      for key, value in var.auth_keys_user_api_token : key => value
    }
  )
  custom_metadata {
    max_versions = 5
  }
}

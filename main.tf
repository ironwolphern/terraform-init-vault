#------------------------------------------------------------------------------
# Main Terraform configuration file
#------------------------------------------------------------------------------
resource "vault_policy" "admin" {
  name   = "admin"
  policy = file("${path.module}/policy/admin-policy.hcl")
}

resource "vault_policy" "devops" {
  name   = "devops"
  policy = file("${path.module}/policy/devops-policy.hcl")
}

resource "vault_policy" "cicd-ro" {
  name   = "cicd-ro"
  policy = file("${path.module}/policy/approle-cicd-ro-policy.hcl")
}

resource "vault_policy" "cicd-rw" {
  name   = "cicd-rw"
  policy = file("${path.module}/policy/approle-cicd-rw-policy.hcl")
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
    token_policies    = [vault_policy.admin.name]
    password          = var.admin_password
    token_ttl         = "1h"
    token_bound_cidrs = var.ip_whitelist
  })
}

resource "vault_generic_endpoint" "devops_user" {
  depends_on           = [vault_auth_backend.userpass]
  path                 = "auth/userpass/users/devops"
  ignore_absent_fields = true

  data_json = jsonencode({
    token_policies    = [vault_policy.devops.name]
    password          = var.devops_password
    token_ttl         = "1h"
    token_bound_cidrs = var.ip_whitelist
  })
}

# Uncomment the following block to enable the Vault AppRole authentication backend
resource "vault_auth_backend" "approle" {
  type = "approle"
  path = "approle"
}

resource "vault_approle_auth_backend_role" "cicd-ro" {
  backend        = vault_auth_backend.approle.path
  role_name      = "cicd-ro"
  token_policies = [vault_policy.cicd-ro.name]

  # AppRole security configuration
  token_ttl             = 3600
  token_max_ttl         = 14400
  token_num_uses        = 0
  secret_id_ttl         = 300
  secret_id_num_uses    = 0
  bind_secret_id        = true
  secret_id_bound_cidrs = var.ip_whitelist
  token_bound_cidrs     = var.ip_whitelist
}

resource "vault_approle_auth_backend_role_secret_id" "cicd-ro" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.cicd-ro.role_name
}

resource "vault_approle_auth_backend_role" "cicd-rw" {
  backend        = vault_auth_backend.approle.path
  role_name      = "cicd-rw"
  token_policies = [vault_policy.cicd-rw.name]

  # AppRole security configuration
  token_ttl             = 3600
  token_max_ttl         = 14400
  token_num_uses        = 0
  secret_id_ttl         = 1800
  secret_id_num_uses    = 0
  bind_secret_id        = true
  secret_id_bound_cidrs = var.ip_whitelist
  token_bound_cidrs     = var.ip_whitelist
}

resource "vault_approle_auth_backend_role_secret_id" "cicd-rw" {
  backend   = vault_auth_backend.approle.path
  role_name = vault_approle_auth_backend_role.cicd-rw.role_name
}

# Uncomment the following block to enable the Vault engine kv-v2
resource "vault_mount" "laboratory" {
  path        = "laboratory"
  type        = "kv"
  options     = { version = "2" }
  description = "Secret KV Version 2 secret engine mount"
}

resource "vault_kv_secret_v2" "ssh" {
  depends_on = [vault_mount.laboratory]
  count      = (var.ssh_keys != null) ? 1 : 0
  mount               = vault_mount.laboratory.path
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
  depends_on = [vault_mount.laboratory]
  count      = (var.pve_auth_keys_userpass != null) ? 1 : 0
  mount               = vault_mount.laboratory.path
  name                = "proxmox/auth/userpass"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      for key, value in var.pve_auth_keys_userpass : key => value
    }
  )
  custom_metadata {
    max_versions = 5
  }
}

resource "vault_kv_secret_v2" "pve_auth_user_api_token" {
  depends_on = [vault_mount.laboratory]
  count      = (var.pve_auth_keys_api != null) ? 1 : 0
  mount               = vault_mount.laboratory.path
  name                = "proxmox/auth/api"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      for key, value in var.pve_auth_keys_api : key => value
    }
  )
  custom_metadata {
    max_versions = 5
  }
}

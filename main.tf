#------------------------------------------------------------------------------
# Main Terraform configuration file
#------------------------------------------------------------------------------
# Uncomment the following block to enable the Vault engine kv-v2
#resource "vault_mount" "secrets" {
#  path        = "secrets"
#  type        = "kv"
#  options     = { version = "2" }
#  description = "Secret KV Version 2 secret engine mount"
#}

resource "vault_kv_secret_v2" "ssh" {
  count = (var.ssh_keys != null) ? 1 : 0
  #mount               = vault_mount.secrets.path
  mount               = "secrets"
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
  #mount               = vault_mount.secrets.path
  mount               = "secrets"
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
  #mount               = vault_mount.secrets.path
  mount               = "secrets"
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

#------------------------------------------------------------------------------
# Outputs for the module
#------------------------------------------------------------------------------
output "admin_username" {
  value = "admin"
}

output "admin_policy_name" {
  value = vault_policy.admin.name
}

output "devops_username" {
  value = "devops"
}

output "devops_policy_name" {
  value = vault_policy.devops.name
}

output "role_id_ro" {
  value     = vault_approle_auth_backend_role.cicd-ro.role_id
  sensitive = true
}

output "secret_id_ro" {
  value     = vault_approle_auth_backend_role_secret_id.cicd-ro.secret_id
  sensitive = true
}

output "role_id_rw" {
  value     = vault_approle_auth_backend_role.cicd-rw.role_id
  sensitive = true
}

output "secret_id_rw" {
  value     = vault_approle_auth_backend_role_secret_id.cicd-rw.secret_id
  sensitive = true
}

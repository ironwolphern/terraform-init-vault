vault_addr  = "http://vault.example.local:8200"
vault_token = "changeme"

ssh_keys = {
  "foo.pub" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0WGP1EZfreNQSJWjV/Fant..."
}

auth_keys_user_password = {
  "user" = "changeit"
}

auth_keys_user_api_token = {
  "user@pve!user_id" = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

# vault_login_approle_role_id = "hvs"
# vault_login_approle_secret_id = "hvs"

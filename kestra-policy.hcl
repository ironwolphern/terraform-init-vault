# Read-only permission on secrets stored at 'secret/data/*'
path "laboratory/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "laboratory/metadata/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Allow rotation of credentials
path "auth/token/create" {
  capabilities = ["create", "update"]
}

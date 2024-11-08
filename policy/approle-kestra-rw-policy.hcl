# Read-Write permission on secrets stored at 'laboratory/data/*'
path "laboratory/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
path "laboratory/metadata/*" {
  capabilities = ["create", "read", "update", "list", "delete", "sudo"]
}

# Manage all AppRoles Secrets IDs
path "auth/approle/role/kestra-ro/secret-id" {
  capabilities = ["create", "read", "update", "list"]
}

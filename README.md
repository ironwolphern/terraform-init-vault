# terraform-init-vault

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=flat&logo=terraform&logoColor=white)
![GitHub License](https://img.shields.io/github/license/ironwolphern/terraform-init-vault)
![GitHub release (with filter)](https://img.shields.io/github/v/release/ironwolphern/terraform-init-vault)
![GitHub pull requests](https://img.shields.io/github/issues-pr/ironwolphern/terraform-init-vault)
![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/ironwolphern/terraform-init-vault)
![GitHub issues](https://img.shields.io/github/issues/ironwolphern/terraform-init-vault)
[![Terraform Lint](https://github.com/ironwolphern/terraform-init-vault/actions/workflows/terraform-validation.yml/badge.svg)](https://github.com/ironwolphern/terraform-init-vault/actions/workflows/terraform-validation.yml)
![Dependabot](https://badgen.net/github/dependabot/ironwolphern/terraform-init-vault)

Terraform for init data in Hashicorp Vault

## Compatibility

This script is meant for use with Terraform 0.13+ and tested using Terraform 1.9+. If you find incompatibilities using Terraform >=0.13, please open an issue.

## Features

1. Upload data to Hashicorp Vault.
2. Inicialize Hashicorp Vault with data.
3. Create users and policies in Hashicorp Vault.
4. Create AppRoles and policies in Hashicorp Vault.

## Usage

Basic usage of this script is as follows:

```shell
terraform init
terraform validate
terraform plan -out=plan_output.tfplan
terraform apply plan_output.tfplan -auto-approve
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.9.0 |
| hashicorp/vault | >= 4.4.0 |

## Providers

| Name | Version |
|------|---------|
| hashicorp/vault | >= 4.4.0 |

## Resources

| Name | Type | Type Resource |
|------|------|---------------|
| admin | resource | vault_policy |
| devops | resource | vault_policy |
| userpass | resource | vault_auth_backend |
| admin_user | resource | vault_generic_endpoint |
| devops_user | resource | vault_generic_endpoint |
| cicd-ro | resource | vault_policy |
| cicd-rw | resource | vault_policy |
| approle | resource | vault_auth_backend |
| cicd-ro | resource | vault_approle_auth_backend_role |
| cicd-ro | resource | vault_approle_auth_backend_role_secret_id |
| cicd-rw | resource | vault_approle_auth_backend_role |
| cicd-rw | resource | vault_approle_auth_backend_role_secret_id |
| laboratory | resource | vault_mount |
| ssh | resource | vault_kv_secret_v2 |
| pve_auth_user_password | resource | vault_kv_secret_v2 |
| pve_auth_user_api_token | resource | vault_kv_secret_v2 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vault_addr | URL of hashicorp Vault Service. | `string` | `` | yes |
| vault_token | Token of user. | `string` | `` | yes |
| admin_password | Password for admin user. | `string` | `` | yes |
| devops_password | Password for devops user. | `string` | `` | yes |
| ip_whitelist | List of IP addresses to whitelist for approles. | `list(string)` | `[]` | no |
| ssh_keys | Map of SSH keys (Name and public key). | `map(string)` | `` | no |
| pve_auth_keys_userpass | Map of Proxmox Authentication userpass (Username and password). | `map(string)` | `` | no |
| pve_auth_keys_api | Map of Proxmox Authentication api (Username and API token). | `map(string)` | `` | no |

## Outputs

| Name | Description | Sensitive |
|------|-------------|-----------|
| admin_username | Username for admin user. | false |
| admin_policy_name | Policy name for admin user. | false |
| devops_username | Username for devops user. | false |
| devops_policy_name | Policy name for devops user. | false |
| role_id_ro | Role ID for cicd-ro approle. | true |
| secret_id_ro | Secret ID for cicd-ro approle. | true |
| role_id_rw | Role ID for cicd-rw approle. | true |
| secret_id_rw | Secret ID for cicd-rw approle. | true |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## *License*

MIT

## *Author Information*

This module was created in 2024 by:

- Fernando Hernández San Felipe (<ironwolphern@outlook.com>)

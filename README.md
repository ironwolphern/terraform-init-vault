# terraform-init-vault

:construction: ***DEVELOPING*** :construction:

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

| Name | Type |
|------|------|
| ssh | resource |
| pve_auth_user_password | resource |
| pve_auth_user_api_token | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vault_addr | URL of hashicorp Vault Service. | `string` | `` | yes |
| vault_token | Token of user. | `string` | `` | yes |
| ssh_keys | Map of SSH keys (Name and public key). | `map(string)` | `` | no |
| auth_keys_user_password | Map of Authentication keys (Username and password). | `map(string)` | `` | no |
| auth_keys_user_api_token | Map of Authentication keys (Username and API token). | `map(string)` | `` | no |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## *License*

MIT

## *Author Information*

This module was created in 2024 by:

- Fernando Hernández San Felipe (<ironwolphern@outlook.com>)

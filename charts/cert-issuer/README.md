# cert-issuer

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

Certificate issuer for Rubin Science Platform

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| rra |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| config.email | string | None, must be set | Contact email address registered with Let's Encrypt |
| config.route53.awsAccessKeyId | string | None, must be set | AWS access key ID for Route 53 (must match `aws-secret-access-key` in Vault secret referenced by `config.vaultSecretPath`) |
| config.route53.hostedZone | string | None, must be set | Route 53 hosted zone in which to create challenge records |
| config.vaultSecretPath | string | None, must be set | Path in Vault to the AWS credentials |
| fullnameOverride | string | `""` | Override the full name for resources (includes the release name) |
| nameOverride | string | `""` | Override the base name for resources |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)

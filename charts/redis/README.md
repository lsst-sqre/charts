# redis

![Version: 1.1.1](https://img.shields.io/badge/Version-1.1.1-informational?style=flat-square)

Simple single-server Redis deployment with configurable storage

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| rra |  |  |

## Source Code

* <https://github.com/lsst-sqre/charts/tree/main/charts/redis>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules for the Redis pod |
| config.secretKey | string | Do not require authentication | Key inside secret from which to get the Redis password. If set, `config.secretName` must also be set. |
| config.secretName | string | Do not require authentication | Name of secret from which to get the Redis password. If set, `config.secretKey` must also be set. |
| fullnameOverride | string | `""` | Override the full name for resources (includes the release name) |
| image.pullPolicy | string | `"IfNotPresent"` | Pull policy for the Redis image |
| image.repository | string | `"redis"` | Redis image to use |
| image.tag | string | `"8.0.3"` | Redis image tag to use |
| nameOverride | string | `""` | Override the base name for resources |
| nodeSelector | object | `{}` | Node selector rules for the Redis pod |
| persistence.accessMode | string | `"ReadWriteOnce"` | Access mode of storage to request |
| persistence.enabled | bool | `true` | Whether to persist Redis storage and thus tokens. Setting this to false will use `emptyDir` and reset all tokens on every restart. |
| persistence.size | string | `"1Gi"` | Amount of persistent storage to request |
| persistence.storageClass | string | `""` | Class of storage to request |
| persistence.volumeClaimName | string | `""` | Use an existing PVC, not dynamic provisioning. If this is set, the size, storageClass, and accessMode settings are ignored. |
| podAnnotations | object | `{}` | Annotations for the Redis pod |
| resources | object | `{}` | Resource limits and requests for the Redis pod |
| tolerations | list | `[]` | Tolerations for the Redis pod |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.0](https://github.com/norwoodj/helm-docs/releases/v1.13.0)

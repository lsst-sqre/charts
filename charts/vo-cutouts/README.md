# vo-cutouts

![Version: 0.2.1](https://img.shields.io/badge/Version-0.2.1-informational?style=flat-square) ![AppVersion: 0.2.0](https://img.shields.io/badge/AppVersion-0.2.0-informational?style=flat-square)

Image cutout service complying with IVOA SODA

**Homepage:** <https://github.com/lsst-sqre/vo-cutouts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| rra |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules for the vo-cutouts frontend pod |
| cloudsql.enabled | bool | `false` | Enable the Cloud SQL Auth Proxy sidecar, used with CloudSQL databases on Google Cloud |
| cloudsql.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for Cloud SQL Auth Proxy images |
| cloudsql.image.repository | string | `"gcr.io/cloudsql-docker/gce-proxy"` | Cloud SQL Auth Proxy image to use |
| cloudsql.image.tag | string | `"1.28.1"` | Cloud SQL Auth Proxy tag to use |
| cloudsql.instanceConnectionName | string | `""` | Instance connection name for a CloudSQL PostgreSQL instance |
| cloudsql.serviceAccount | string | `""` | The Google service account that has an IAM binding to the `vo-cutouts` Kubernetes service accounts and has the `cloudsql.client` role |
| config.butlerRepository | string | None, must be set | Configuration for the Butler repository to use |
| config.databaseUrl | string | None, must be set | URL for the PostgreSQL database |
| config.gcsBucketUrl | string | None, must be set | URL for the GCS bucket into which to store cutouts (must start with `s3`) |
| config.lifetime | int | 604800 (1 week) | Lifetime of job results in seconds |
| config.loglevel | string | `"INFO"` | Choose from the text form of Python logging levels |
| config.syncTimeout | int | 60 (1 minute) | Timeout for results from a sync cutout in seconds |
| config.timeout | int | 600 (10 minutes) | Timeout for a single cutout job in seconds |
| cutoutWorker.affinity | object | `{}` | Affinity rules for the cutout worker pod |
| cutoutWorker.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for cutout workers |
| cutoutWorker.image.repository | string | `"lsstsqre/centos"` | Stack image to use for cutouts |
| cutoutWorker.image.tag | string | `"7-stack-lsst_distrib-w_2022_06"` | Stack image tag to use |
| cutoutWorker.nodeSelector | object | `{}` | Node selection rules for the cutout worker pod |
| cutoutWorker.podAnnotations | object | `{}` | Annotations for the cutout worker pod |
| cutoutWorker.replicaCount | int | `1` | Number of cutout worker pods to start |
| cutoutWorker.resources | object | `{}` | Resource limits and requests for the cutout worker pod |
| cutoutWorker.tolerations | list | `[]` | Tolerations for the cutout worker pod |
| databaseWorker.affinity | object | `{}` | Affinity rules for the database worker pod |
| databaseWorker.nodeSelector | object | `{}` | Node selection rules for the database worker pod |
| databaseWorker.podAnnotations | object | `{}` | Annotations for the database worker pod |
| databaseWorker.replicaCount | int | `1` | Number of database worker pods to start |
| databaseWorker.resources | object | `{}` | Resource limits and requests for the database worker pod |
| databaseWorker.tolerations | list | `[]` | Tolerations for the database worker pod |
| fullnameOverride | string | `""` | Override the full name for resources (includes the release name) |
| image.pullPolicy | string | `"IfNotPresent"` | Pull policy for the vo-cutouts image |
| image.repository | string | `"lsstsqre/vo-cutouts"` | vo-cutouts image to use |
| image.tag | string | The appVersion of the chart | Tag of vo-cutouts image to use |
| imagePullSecrets | list | `[]` | Secret names to use for all Docker pulls |
| ingress.annotations | object | `{}` | Additional annotations to add to the ingress |
| ingress.gafaelfawrAuthQuery | string | `"scope=read:image"` | Gafaelfawr auth query string |
| ingress.host | string | `""` | Hostname for the ingress |
| ingress.tls | list | `[]` | Configures TLS for the ingress if needed. If multiple ingresses share the same hostname, only one of them needs a TLS configuration. |
| nameOverride | string | `""` | Override the base name for resources |
| nodeSelector | object | `{}` | Node selector rules for the vo-cutouts frontend pod |
| podAnnotations | object | `{}` | Annotations for the vo-cutouts frontend pod |
| redis.affinity | object | `{}` | Affinity rules for the Redis pod |
| redis.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for the Redis image |
| redis.image.repository | string | `"redis"` | Redis image to use |
| redis.image.tag | string | `"6.2.6"` | Redis image tag to use |
| redis.nodeSelector | object | `{}` | Node selection rules for the Redis pod |
| redis.persistence.accessMode | string | `"ReadWriteOnce"` | Access mode of storage to request |
| redis.persistence.enabled | bool | `true` | Whether to persist Redis storage and thus tokens. Setting this to false will use `emptyDir` and reset all tokens on every restart. Only use this for a test deployment. |
| redis.persistence.size | string | `"100Mi"` | Amount of persistent storage to request |
| redis.persistence.storageClass | string | `""` | Class of storage to request |
| redis.persistence.volumeClaimName | string | `""` | Use an existing PVC, not dynamic provisioning. If this is set, the size, storageClass, and accessMode settings are ignored. |
| redis.podAnnotations | object | `{}` | Pod annotations for the Redis pod |
| redis.tolerations | list | `[]` | Tolerations for the Redis pod |
| replicaCount | int | `1` | Number of web frontend pods to start |
| resources | object | `{}` | Resource limits and requests for the vo-cutouts frontend pod |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. If CloudSQL is in use, the annotation specifying the Google service account will also be added. |
| serviceAccount.create | bool | `false` | Force creation of a service account. Normally, no service account is used or mounted. If CloudSQL is enabled, a service account is always created regardless of this value. |
| serviceAccount.name | string | Name based on the fullname template | Name of the service account to use |
| tolerations | list | `[]` | Tolerations for the vo-cutouts frontend pod |
| vaultSecretsPath | string | None, must be set | Path to the Vault secret (`secret/k8s_operator/<host>/vo-cutouts`, for example) |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)

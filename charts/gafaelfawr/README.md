# gafaelfawr

![Version: 4.4.4](https://img.shields.io/badge/Version-4.4.4-informational?style=flat-square) ![AppVersion: 3.4.1](https://img.shields.io/badge/AppVersion-3.4.1-informational?style=flat-square)

The Gafaelfawr authentication and authorization system

**Homepage:** <https://gafaelfawr.lsst.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| rra |  |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity rules for the Gafaelfawr frontend pod |
| cloudsql.enabled | bool | `false` | Enable the Cloud SQL Auth Proxy sidecar, used with CloudSQL databases on Google Cloud |
| cloudsql.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for Cloud SQL Auth Proxy images |
| cloudsql.image.repository | string | `"gcr.io/cloudsql-docker/gce-proxy"` | Cloud SQL Auth Proxy image to use |
| cloudsql.image.tag | string | `"1.28.0-buster"` | Cloud SQL Auth Proxy tag to use |
| cloudsql.instanceConnectionName | string | `""` | Instance connection name for a CloudSQL PostgreSQL instance |
| cloudsql.serviceAccount | string | `""` | The Google service account that has an IAM binding to the `gafaelfawr` and `gafaelfawr-tokens` Kubernetes service accounts and has the `cloudsql.client` role |
| config.cilogon.clientId | string | `""` | CILogon client ID. One and only one of this or config.github.clientId must be set. |
| config.cilogon.loginParams | object | `{"skin":"LSST"}` | Additional parameters to add |
| config.cilogon.redirectUrl | string | `/login` at the value of config.host | Return URL given to CILogon (must match the CILogon configuration) |
| config.cilogon.test | bool | `false` | Whether to use the test instance of CILogon |
| config.databaseUrl | string | None, must be set | URL for the PostgreSQL database |
| config.errorFooter | string | `""` | HTML footer to add to any login error page (inside a <p> tag). |
| config.github.clientId | string | `""` | GitHub client ID. One and only one of this or config.cilogon.clientId must be set. |
| config.groupMapping | object | `{}` | Defines a mapping of scopes to groups that provide that scope. Tokens from an OpenID Connect provider such as CILogon that include groups in an `isMemberOf` claim will be granted scopes based on this mapping. |
| config.host | string | None, must be set | Used to construct issuers and URLs. |
| config.initialAdmins | list | `[]` | Usernames to add as administrators when initializing a new database. Used only if there are no administrators. |
| config.issuer.expMinutes | int | `43200` (30 days) | Session length and token expiration (in minutes) |
| config.issuer.influxdb.enabled | bool | `false` | Whether to issue tokens for InfluxDB. If set to true, `influxdb-secret` must be set in the Gafaelfawr secret. |
| config.issuer.influxdb.username | string | `""` | If set, force all InfluxDB tokens to have that username instead of the authenticated identity of the user requesting a token |
| config.knownScopes | object | See the `values.yaml` file | Names and descriptions of all scopes in use. This is used to populate the new token creation page. Only scopes listed here will be options when creating a new token. |
| config.loglevel | string | `"INFO"` | Choose from the text form of Python logging levels |
| config.oidcServer.enabled | bool | `false` | Whether to support OpenID Connect clients. If set to true, `oidc-server-secrets` must be set in the Gafaelfawr secret. |
| config.proxies | list | [`10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`] | List of netblocks used for internal Kubernetes IP addresses, used to determine the true client IP for logging |
| fullnameOverride | string | `""` | Override the full name for resources (includes the release name) |
| image.pullPolicy | string | `"IfNotPresent"` | Pull policy for the Gafaelfawr image |
| image.repository | string | `"lsstsqre/gafaelfawr"` | Gafaelfawr image to use |
| image.tag | string | The appVersion of the chart | Tag of Gafaelfawr image to use |
| imagePullSecrets | list | `[]` | Secret names to use for all Docker pulls |
| ingress.annotations | object | `{}` | Additional annotations to add to the ingress |
| ingress.enabled | bool | `true` | Whether to create an ingress |
| ingress.host | string | `""` | Hostname for the ingress. This should normally be the same as config.host. |
| ingress.tls | list | `[]` | Configures TLS for the ingress if needed. If multiple ingresses share the same hostname, only one of them needs a TLS configuration. |
| nameOverride | string | `""` | Override the base name for resources |
| networkPolicy.enabled | bool | `false` | Whether to restrict access to the Gafaelfawr service. Only enable if the ingress controller namespace is tagged with `gafaelfawr.lsst.io/ingress: "true"`. |
| nodeSelector | object | `{}` | Node selector rules for the Gafaelfawr frontend pod |
| podAnnotations | object | `{}` | Annotations for the Gafaelfawr frontend pod |
| redis.affinity | object | `{}` | Affinity rules for the Redis pod |
| redis.image.pullPolicy | string | `"IfNotPresent"` | Pull policy for the Redis image |
| redis.image.repository | string | `"redis"` | Redis image to use |
| redis.image.tag | string | `"6.2.6"` | Redis image tag to use |
| redis.nodeSelector | object | `{}` | Node selection rules for the Redis pod |
| redis.persistence.accessMode | string | `"ReadWriteOnce"` | Access mode of storage to request |
| redis.persistence.enabled | bool | `true` | Whether to persist Redis storage and thus tokens. Setting this to false will use `emptyDir` and reset all tokens on every restart. Only use this for a test deployment. |
| redis.persistence.size | string | `"1Gi"` | Amount of persistent storage to request |
| redis.persistence.storageClass | string | `""` | Class of storage to request |
| redis.persistence.volumeClaimName | string | `""` | Use an existing PVC, not dynamic provisioning. If this is set, the size, storageClass, and accessMode settings are ignored. |
| redis.podAnnotations | object | `{}` | Pod annotations for the Redis pod |
| redis.tolerations | list | `[]` | Tolerations for the Redis pod |
| replicaCount | int | `1` | Number of web frontend pods to start |
| resources | object | `{}` | Resource limits and requests for the Gafaelfawr frontend pod |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account. If CloudSQL is in use, the annotation specifying the Google service account will also be added. |
| serviceAccount.create | bool | `false` | Force creation of a service account. Normally, no service account is used or mounted. If CloudSQL is enabled, a service account is always created regardless of this value. |
| serviceAccount.name | string | Name based on the fullname template | Name of the service account to use |
| tokens.affinity | object | `{}` | Affinity rules for the token management pod |
| tokens.nodeSelector | object | `{}` | Node selection rules for the token management pod |
| tokens.podAnnotations | object | `{}` | Annotations for the token management pod |
| tokens.resources | object | `{}` | Resource limits and requests for the Gafaelfawr token management pod |
| tokens.serviceAccount.annotations | object | `{}` | Annotations to add to the service account. If CloudSQL is in use, the annotation specifying the Google service account will also be added. |
| tokens.serviceAccount.create | bool | `true` | Create a Kubernetes service account to use for token management with a cluster role that allows it to list, get, patch, and delete secrets in any namespace. Even if true, it is only created if tokens.secrets is non-empty. |
| tokens.serviceAccount.name | string | Formed by appending `-tokens` to the fullname template | Name of the service account to use |
| tokens.tolerations | list | `[]` | Tolerations for the token management pod |
| tolerations | list | `[]` | Tolerations for the Gafaelfawr frontend pod |
| vaultSecretsPath | string | None, must be set | Path to the Vault secret (`secret/k8s_operator/<host>/gafaelfawr`, for example) |


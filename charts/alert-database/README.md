# alert-database

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

Archival database of alerts sent through the alert stream.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| swnelson | swnelson@uw.edu |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ingester.gcp.projectID | string | `""` | Project ID which has the above GCP IAM service account |
| ingester.gcp.serviceAccountName | string | `""` | Name of a service account which has credentials granting access to the alert database's backing storage buckets. |
| ingester.image.imagePullPolicy | string | `"IfNotPresent"` |  |
| ingester.image.repository | string | `"swnelson/alert_database_ingester"` |  |
| ingester.image.tag | string | `"v1.1.0"` |  |
| ingester.kafka.cluster | string | `"alert-broker"` | Name of a Strimzi Kafka cluster to connect to. |
| ingester.kafka.port | int | `9092` | Port to connect to on the Strimzi Kafka cluster. It should be an internal listener that expects SCRAM SHA-512 auth. |
| ingester.kafka.strimziAPIVersion | string | `"v1beta2"` | API version of the Strimzi installation's custom resource definitions |
| ingester.kafka.topic | string | `"alerts"` | Name of the topic which will holds alert data. |
| ingester.kafka.user | string | `"alert-database-ingester"` | The username of the Kafka user identity used to connect to the broker. |
| ingester.schemaRegistryURL | string | `""` | URL of a schema registry instance |
| ingester.serviceAccountName | string | `"alert-database-ingester"` | The name of the Kubernetes ServiceAccount (*not* the Google Cloud IAM service account!) which is used by the alert database ingester. |
| storage.gcp.bucket | string | `""` | Name of a Google Cloud Storage bucket in GCP |
| storage.gcp.project | string | `""` | Name of a GCP project that has a bucket for database storage |


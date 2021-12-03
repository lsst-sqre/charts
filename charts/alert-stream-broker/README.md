# alert-stream-broker

![Version: 2.0.0](https://img.shields.io/badge/Version-2.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

Kafka broker cluster for distributing alerts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| swnelson | swnelson@uw.edu |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.name | string | `"alert-broker"` | Name used for the Kafka broker, and used by Strimzi for many annotations. |
| kafka.config | object | `{"log.retention.bytes":"644245094400","log.retention.hours":168,"offsets.retention.minutes":10080}` | Configuration overrides for the Kafka server. |
| kafka.config."log.retention.bytes" | string | `"644245094400"` | Maximum retained number of bytes for a topic's data. This is a string -- to avoid YAML type conversion issues for large numbers. |
| kafka.config."log.retention.hours" | int | `168` | Number of days for a topic's data to be retained. |
| kafka.config."offsets.retention.minutes" | int | `10080` | Number of minutes for a consumer group's offsets to be retained. |
| kafka.externalListener.bootstrap.host | string | `""` | Hostname that should be used by clients who want to connect to the broker through the bootstrap address. |
| kafka.externalListener.bootstrap.ip | string | `""` | IP address that should be used by the broker's external bootstrap load balancer for access from the internet. The format of this is a string like "192.168.1.1". |
| kafka.externalListener.brokers | list | `[]` | List of hostname and IP for each broker. The format of this is a list of maps with 'ip' and 'host' keys. For example:    - ip: "192.168.1.1"      host: broker-0.example    - ip: "192.168.1.2"      host: broker-1.example Each replica should get a host and IP. If these are unset, then IP addresses will be chosen automatically by the Kubernetes cluster's LoadBalancer controller, and hostnames will be unset, which will break TLS connections. |
| kafka.interBrokerProtocolVersion | float | `2.8` | Version of the protocol for inter-broker communication, see https://strimzi.io/docs/operators/latest/deploying.html#ref-kafka-versions-str. |
| kafka.logMessageFormatVersion | float | `2.8` | Encoding version for messages, see https://strimzi.io/docs/operators/latest/deploying.html#ref-kafka-versions-str. |
| kafka.replicas | int | `3` | Number of Kafka broker replicas to run. |
| kafka.storage.size | string | `"1000Gi"` | Size of the backing storage disk for each of the Kafka brokers. |
| kafka.storage.storageClassName | string | `"standard"` | Name of a StorageClass to use when requesting persistent volumes. |
| kafka.version | string | `"2.8.1"` | Version of Kafka to deploy. |
| strimziAPIVersion | string | `"v1beta2"` | Version of the Strimzi Custom Resource API. The correct value depends on the deployed version of Strimzi. See [this blog post](https://strimzi.io/blog/2021/04/29/api-conversion/) for more. |
| superusers | list | `["kafka-admin"]` | A list of usernames for users who should have global admin permissions. These users will be created, along with their credentials. |
| zookeeper.replicas | int | `3` | Number of Zookeeper replicas to run. |
| zookeeper.storage.size | string | `"1000Gi"` | Size of the backing storage disk for each of the Zookeeper instances. |
| zookeeper.storage.storageClassName | string | `"standard"` | Name of a StorageClass to use when requesting persistent volumes. |


# alert-stream-broker

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

Kafka broker cluster for distributing alerts

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Spencer Nelson | swnelson@uw.edu |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.name | string | `"alert-broker"` | Name used for the Kafka broker, and used by Strimzi for many annotations. |
| kafka.interBrokerProtocolVersion | float | `2.8` | Version of the protocol for inter-broker communication, see https://strimzi.io/docs/operators/latest/deploying.html#ref-kafka-versions-str. |
| kafka.logMessageFormatVersion | float | `2.8` | Encoding version for messages, see https://strimzi.io/docs/operators/latest/deploying.html#ref-kafka-versions-str. |
| kafka.replicas | int | `3` | Number of Kafka broker replicas to run. |
| kafka.storage | string | `"300Gi"` | Size of the backing storage disk for the Kafka brokers. |
| kafka.version | string | `"2.8.1"` | Version of Kafka to deploy. |
| strimziAPIVersion | string | `"v1beta2"` | Version of the Strimzi Custom Resource API. The correct value depends on the deployed version of Strimzi. See [this blog post](https://strimzi.io/blog/2021/04/29/api-conversion/) for more. |
| superusers | list | `["kafka-admin"]` | A list of usernames for users who should have global admin permissions. These users will be created, along with their credentials. |
| zookeeper.replicas | int | `3` | Number of Zookeeper replicas to run. |
| zookeeper.storage | string | `"50Gi"` | Size of the backing storage disk for the Zookeeper instances. |


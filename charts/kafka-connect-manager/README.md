# kafka-connect-manager

![Version: 0.9.6](https://img.shields.io/badge/Version-0.9.6-informational?style=flat-square) ![AppVersion: 0.9.3](https://img.shields.io/badge/AppVersion-0.9.3-informational?style=flat-square)

A Helm chart to deploy kafka connectors

**Homepage:** <https://kafka-connect-manager.lsst.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| afausti | afausti@lsst.org | https://afausti.github.io/ |

## Source Code

* <https://github.com/lsst-sqre/kafka-connect-manager>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.kafkaBrokerUrl | string | `"cp-helm-charts-cp-kafka-headless.cp-helm-charts:9092"` | Kafka broker URL. |
| env.kafkaConnectUrl | string | `"http://cp-helm-charts-cp-kafka-connect.cp-helm-charts:8083"` | Kafka connnect URL. |
| image.pullPolicy | string | `"Always"` |  |
| image.repository | string | `"lsstsqre/kafkaconnect"` |  |
| image.tag | string | `"0.9.3"` |  |
| influxdbSink.influxdb-sink | object | `{"autoUpdate":true,"checkInterval":"15000","connectInfluxDb":"","connectInfluxErrorPolicy":"THROW","connectInfluxMaxRetries":"10","connectInfluxRetryInterval":"60000","connectInfluxUrl":"http://localhost:8086","connectProgressEnabled":false,"enabled":false,"excludedTopicRegex":"","influxSecret":"influxdb-auth","name":"influxdb-sink","tasksMax":1,"timestamp":"sys_time()","topicRegex":".*"}` | To create multiple instances of this connector repeat this block. The name of the instance, "influxdb-sink" in this case, is used as scope for the template variables. |
| influxdbSink.influxdb-sink.autoUpdate | bool | `true` | If autoUpdate is enabled, check for new kafka topics. If they match topicRegex and excludedTopicRegex add them to the connector dynamically. |
| influxdbSink.influxdb-sink.checkInterval | string | `"15000"` | The interval, in milliseconds, to check for new topics and update the connector. |
| influxdbSink.influxdb-sink.connectInfluxDb | string | `""` | InfluxDB database to write to. |
| influxdbSink.influxdb-sink.connectInfluxErrorPolicy | string | `"THROW"` | Error policy. |
| influxdbSink.influxdb-sink.connectInfluxMaxRetries | string | `"10"` | The maximum number of times a message is retried. |
| influxdbSink.influxdb-sink.connectInfluxRetryInterval | string | `"60000"` | The interval, in milliseconds, between retries. Only valid when the connectInfluxErrorPolicy is set to `RETRY`. |
| influxdbSink.influxdb-sink.connectInfluxUrl | string | `"http://localhost:8086"` | InfluxDB URL, can be internal to the cluster. |
| influxdbSink.influxdb-sink.connectProgressEnabled | bool | `false` | Enables the output for how many records have been processed. |
| influxdbSink.influxdb-sink.enabled | bool | `false` | Whether this connector instance is deployed. |
| influxdbSink.influxdb-sink.excludedTopicRegex | string | `""` | Regex to exclude topics from the list of selected topics from Kafka. |
| influxdbSink.influxdb-sink.influxSecret | string | `"influxdb-auth"` | Name of the kubernetes secret with InfluxDB credentials. |
| influxdbSink.influxdb-sink.name | string | `"influxdb-sink"` | Name of the connector instance to create. |
| influxdbSink.influxdb-sink.tasksMax | int | `1` | Number of Kafka Connect tasks. |
| influxdbSink.influxdb-sink.timestamp | string | `"sys_time()"` | Timestamp to be used as the InfluxDB time, if not specified `sys_time()` is used. |
| influxdbSink.influxdb-sink.topicRegex | string | `".*"` | Regex to select topics from Kafka. |
| jdbcSink.autoCreate | string | `"true"` | Whether to automatically create the destination table. |
| jdbcSink.autoEvolve | string | `"false"` | Whether to automatically add columns in the table schema. |
| jdbcSink.batchSize | string | `"3000"` | Specifies how many records to attempt to batch together for insertion into the destination table. |
| jdbcSink.connectionPassword | string | `""` | Database connection password. |
| jdbcSink.connectionUrl | string | `"jdbc:postgresql://localhost:5432/mydb"` | Database connection URL. |
| jdbcSink.connectionUser | string | `""` | Database connection username. |
| jdbcSink.dbTimezone | string | `"UTC"` | Name of the JDBC timezone that should be used in the connector when inserting time-based values. |
| jdbcSink.enabled | bool | `false` | Whether the JDBC Sink connector is deployed. |
| jdbcSink.insertMode | string | `"insert"` | The insertion mode to use. Supported modes are: `insert`, `upsert` and `update`. |
| jdbcSink.maxRetries | string | `"10"` | The maximum number of times to retry on errors before failing the task. |
| jdbcSink.name | string | `"postgres-sink"` | Name of the connector to create. |
| jdbcSink.retryBackoffMs | string | `"3000"` | The time in milliseconds to wait following an error before a retry attempt is made. |
| jdbcSink.tableNameFormat | string | `"${topic}"` | A format string for the destination table name. |
| jdbcSink.tasksMax | string | `"10"` | Number of Kafka Connect tasks. |
| jdbcSink.topicRegex | string | `".*"` | Regex for selecting topics. |
| mirrorMaker2.enabled | bool | `false` | Whether the MirrorMaker 2 connectors (heartbeat, checkpoint and mirror-source) are deployed. |
| mirrorMaker2.name | string | `"replicator"` | Name od the connector to create. |
| mirrorMaker2.replicationPolicySeparator | string | `"."` | Separator used to format the remote topic name. Use an empty string if sourceClusterAlias is empty. |
| mirrorMaker2.sourceClusterAlias | string | `"src"` | Alias for the source cluster. The remote topic name is prefixed by this value. Use an empty string to preserve the name of the source topic in the destination cluster. |
| mirrorMaker2.sourceClusterBootstrapServers | string | `"localhost:31090"` | Source Kafka cluster. |
| mirrorMaker2.syncTopicAclsEnabled | bool | `false` | Whether to monitor source cluster ACLs for changes. |
| mirrorMaker2.targetClusterAlias | string | `"destn"` | Name of the destination cluster. |
| mirrorMaker2.targetClusterBootstrapServers | string | `"localhost:31090"` | Destination Kafka cluster. |
| mirrorMaker2.tasksMax | int | `1` | Number of Kafka Connect tasks. |
| mirrorMaker2.topicRegex | string | `".*"` | Regex for selecting topics. Comma-separated lists are also supported. |
| s3Sink.awsSecret | string | `"aws-secret"` | Name of the Kubernetes secret with the `aws_access_key_id` and `aws_secret_access_key` keys. |
| s3Sink.behaviorOnNullValues | string | `"fail"` | How to handle records with a null value (for example, Kafka tombstone records). Valid options are ignore and fail. |
| s3Sink.checkInterval | string | `"15000"` | The interval, in milliseconds, to check for new topics and update the connector. |
| s3Sink.enabled | bool | `false` | Whether the Amazon S3 Sink connector is deployed. It is configured to use the Parquet format class with Snappy compression and a time based partitioner. |
| s3Sink.excludedTopicRegex | string | `""` | Regex to exclude topics from the list of selected topics from Kafka. |
| s3Sink.flushSize | string | `"1000"` | Number of records written to store before invoking file commits. |
| s3Sink.locale | string | `"en-US"` | The locale to use when partitioning with TimeBasedPartitioner. |
| s3Sink.name | string | `"s3-sink"` | Name of the connector to create. |
| s3Sink.partitionDurationMs | string | `"3600000"` | The duration of a partition in milliseconds, used by TimeBasedPartitioner. Default is 1h for an hourly based partitioner. |
| s3Sink.pathFormat | string | `"'year'=YYYY/'month'=MM/'day'=dd/'hour'=HH"` | Pattern used to format the path in the S3 object name. |
| s3Sink.rotateIntervalMs | string | `"600000"` | The time interval in milliseconds to invoke file commits. Set to 10 minutes by default. |
| s3Sink.s3BucketName | string | `""` | s3 bucket name. Must exist already. |
| s3Sink.s3PartRetries | int | `3` | Maximum number of retry attempts for failed requests. Zero means no retries. |
| s3Sink.s3Region | string | `"us-east-1"` | s3 region |
| s3Sink.s3RetryBackoffMs | int | `200` | How long to wait in milliseconds before attempting the first retry of a failed S3 request. |
| s3Sink.s3SchemaCompatibility | string | `"NONE"` | s3 schema compatibility |
| s3Sink.schemaCacheConfig | int | `5000` | The size of the schema cache used in the Avro converter. |
| s3Sink.tasksMax | int | `1` | Number of Kafka Connect tasks. |
| s3Sink.timestampExtractor | string | `"Record"` | The extractor determines how to obtain a timestamp from each record. |
| s3Sink.timestampField | string | `""` | The record field to be used as timestamp by the timestamp extractor. Only applies if timestampExtractor is set to RecordField. |
| s3Sink.timezone | string | `"UTC"` | The timezone to use when partitioning with TimeBasedPartitioner. |
| s3Sink.topicsDir | string | `"topics"` | Top level directory to store the data ingested from Kafka. |
| s3Sink.topicsRegex | string | `".*"` | Regex to select topics from Kafka. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)

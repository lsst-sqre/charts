{{/*
Create chart name and version as used by the chart label.
*/}}

{{- define "kafka-connect-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "kafka-connect-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "influxdb.user" -}}
{{- printf "%s" .Values.influxdb.user | b64enc -}}
{{- end }}

{{- define "influxdb.password" -}}
{{- printf "%s" .Values.influxdb.password | b64enc -}}
{{- end -}}

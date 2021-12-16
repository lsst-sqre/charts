{{/* -*- go-template -*- */}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "alertDatabase.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/* Name for the ingester */}}
{{- define "alertDatabase.ingesterName" -}}
{{- printf "%s-ingester-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "alertDatabase.labels" -}}
helm.sh/chart: {{ include "alertDatabase.chart" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Ingester selector labels
*/}}
{{- define "alertDatabase.ingesterSelectorLabels" -}}
app.kubernetes.io/name: {{ include "alertDatabase.ingesterName" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

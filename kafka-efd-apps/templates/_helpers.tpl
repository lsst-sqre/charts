{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kafka-efd-apps.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "githubUser" }}
{{- printf "%s" .Values.secret.githubUser | b64enc }}
{{- end }}

{{- define "githubToken" }}
{{- printf "%s" .Values.secret.githubToken | b64enc }}
{{- end }}

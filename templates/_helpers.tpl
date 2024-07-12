{{/*
Expand the name of the chart.
*/}}
{{- define "retailcode-mtn.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "retailcode-mtn.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "retailcode-mtn.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "retailcode-mtn.labels" -}}
helm.sh/chart: {{ include "retailcode-mtn.chart" . }}
{{ include "retailcode-mtn.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "retailcode-mtn.selectorLabels" -}}
app.kubernetes.io/name: {{ include "retailcode-mtn.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/**Portal Deployment*/}}

{{- define "retailcode-mtn.portal.name" -}}
{{- printf "%s-portal" .Release.Name -}}
{{- end -}}

{{- define "retailcode-mtn.portal.fullname" -}}
{{- printf "%s-portal" .Release.Name -}}
{{- end -}}

{{- define "retailcode-mtn.portal.labels" -}}
helm.sh/chart: {{ include "retailcode-mtn.chart" . }}
{{ include "retailcode-mtn.portal.selectorLabels" . }}
{{- end -}}

{{- define "retailcode-mtn.portal.selectorLabels" -}}
app.kubernetes.io/name: {{ include "retailcode-mtn.portal.name" . }}
app.kubernetes.io/instance: {{ include "retailcode-mtn.portal.name" . }}
{{- end }}


{{/**USSD Gateway Deployment*/}}

{{- define "retailcode-mtn.ussdgateway.name" -}}
{{- printf "%s-ussdgateway" .Release.Name -}}
{{- end -}}

{{- define "retailcode-mtn.ussdgateway.fullname" -}}
{{- printf "%s-ussdgateway" .Release.Name -}}
{{- end -}}

{{- define "retailcode-mtn.ussdgateway.labels" -}}
helm.sh/chart: {{ include "retailcode-mtn.chart" . }}
{{ include "retailcode-mtn.ussdgateway.selectorLabels" . }}
{{- end -}}

{{- define "retailcode-mtn.ussdgateway.selectorLabels" -}}
app.kubernetes.io/name: {{ include "retailcode-mtn.ussdgateway.name" . }}
app.kubernetes.io/instance: {{ include "retailcode-mtn.ussdgateway.name" . }}
{{- end }}


{{- define "retailcode-mtn.securityContext" -}}
securityContext:
  privileged: {{ .Values.securityContext.privileged }}
  allowPrivilegeEscalation: {{ .Values.securityContext.allowPrivilegeEscalation }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
  capabilities:
    drop:
      - "ALL"
  seccompProfile:
    type: {{ .Values.securityContext.seccompProfile.type }}
{{- end -}}

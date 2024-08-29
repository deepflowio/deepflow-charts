{{/*
Expand the name of the chart.
*/}}
{{- define "byconity.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "byconity.fullname" -}}
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
{{- define "byconity.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "byconity.labels" -}}
helm.sh/chart: {{ include "byconity.chart" . }}
{{ include "byconity.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "byconity.selectorLabels" -}}
app.kubernetes.io/name: {{ include "byconity.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "byconity.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "byconity.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create common environment variables to use
*/}}
{{- define "byconity.commonEnvs" -}}
- name: MY_POD_NAMESPACE
  valueFrom:
    fieldRef:
      fieldPath: "metadata.namespace"
- name: MY_POD_NAME
  valueFrom:
    fieldRef:
      fieldPath: "metadata.name"
- name: MY_UID
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: "metadata.uid"
- name: MY_POD_IP
  valueFrom:
    fieldRef:
      fieldPath: "status.podIP"
- name: MY_HOST_IP
  valueFrom:
    fieldRef:
      fieldPath: "status.hostIP"
{{- end }}

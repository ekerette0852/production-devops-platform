# Production Web Outage — Incident Response Lab

## Overview

This lab demonstrates a production-style incident response workflow using Kubernetes, Prometheus, and Argo CD.

A controlled outage was introduced into the `production-web` application to validate monitoring, alerting, recovery procedures, and GitOps reconciliation.

## Environment

- Kubernetes
- Prometheus
- Prometheus Operator
- Argo CD
- GitOps
- Linux / Ubuntu Server
- kubectl

Application:

- Deployment: `production-web`
- Namespace: `production`
- Desired replicas: 3

## Monitoring and Alerting

A custom PrometheusRule named:

`production-web-alerts`

was created in the `monitoring` namespace.

The rule monitors the availability of the `production-web` deployment.

Alert:

`ProductionWebUnavailable`

The alert is triggered when the deployment has fewer than one available replica for more than one minute.

PromQL expression:

```promql
kube_deployment_status_replicas_available{
  namespace="production",
  deployment="production-web"
} < 1

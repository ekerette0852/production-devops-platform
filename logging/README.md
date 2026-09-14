# Kubernetes Centralized Logging with Grafana Loki and Alloy

## Overview

This project implements a centralized Kubernetes logging platform using
Grafana Loki, Grafana Alloy, and Grafana.

Grafana Alloy discovers Kubernetes workloads and collects container logs.
The logs are enriched with Kubernetes metadata and forwarded to Loki for
centralized storage and querying. Grafana provides the interface for
searching and analyzing the logs.

## Architecture

Kubernetes Pods
        |
        v
Grafana Alloy
        |
        | Kubernetes discovery and log collection
        v
Loki Gateway
        |
        v
Grafana Loki
        |
        v
Grafana Explore

## Technologies

- Kubernetes
- Helm
- Grafana Alloy
- Grafana Loki
- Grafana
- Linux

## Versions

- Grafana Alloy Helm Chart: 1.12.1
- Grafana Alloy: v1.19.2
- Grafana Loki Helm Chart: 6.49.0
- Grafana Loki: 3.6.3

## Log Collection

Grafana Alloy automatically discovers Kubernetes pods and attaches useful
metadata to collected logs, including:

- Namespace
- Pod
- Container
- Application

Logs are forwarded to the Loki gateway using Kubernetes internal DNS:

http://loki-gateway.logging.svc.cluster.local/loki/api/v1/push

## Loki Deployment

Loki is deployed in SingleBinary mode with:

- TSDB schema
- Filesystem object storage
- 10Gi persistent storage
- Loki Gateway
- Authentication disabled for the isolated homelab environment

## Verification

The logging namespace contains healthy Alloy and Loki workloads with no
container restarts.

Log ingestion was verified through Grafana Explore using LogQL queries.

Example:

{container="nginx"}

The query successfully returned Kubernetes container logs from Loki.

## Repository Structure

logging/
├── alloy/
│   └── values.yaml
├── loki/
│   └── values.yaml
├── screenshots/
└── README.md

## Skills Demonstrated

- Kubernetes administration
- Helm deployments
- Centralized logging
- Kubernetes service discovery
- Log aggregation
- LogQL
- Observability
- Kubernetes networking and DNS
- Linux troubleshooting
- Production-style documentation

## Grafana Loki Verification

Kubernetes container logs are collected by Grafana Alloy and forwarded to Loki for centralized storage and querying.

Logs were successfully queried through Grafana Explore using LogQL:

```text
{container="nginx"}

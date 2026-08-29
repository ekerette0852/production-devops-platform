# Production DevOps Platform Architecture

## Overview

This project implements an end-to-end CI/CD and GitOps deployment pipeline with separate staging and production environments.

Application changes flow through automated build, containerization, staging deployment, validation, manual production approval, and production promotion.

## Deployment Flow

```mermaid
flowchart LR
    A[Developer] --> B[GitHub]
    B --> C[Jenkins]
    C --> D[Build Container Image]
    D --> E[GitHub Container Registry]
    E --> F[Update GitOps Repository]
    F --> G[Staging Kubernetes]
    G --> H[Validate Staging]
    H --> I{Manual Approval}
    I -->|Approved| J[Promote Same Image]
    J --> K[Production GitOps]
    K --> L[Production Kubernetes]

# Kubernetes NetworkPolicy Security Lab

## Overview

This lab demonstrates Kubernetes network segmentation using a NetworkPolicy in the `production` namespace.

The goal was to restrict access to the `production-web` application so that only explicitly authorized pods can communicate with it on TCP port 80.

## Security Objective

Implement a least-privilege network model where:

- The `production-web` application is protected by a NetworkPolicy.
- Unlabeled/unauthorized pods cannot connect to the application.
- Only pods with the required label can access the application.
- Production application pods remain healthy after the policy is applied.

## NetworkPolicy

The policy protects pods matching:

```yaml
podSelector:
  matchLabels:
    app: production-web

Ingress traffic is allowed on:

```text
TCP/80
```

only from pods matching:

```yaml
access: production-web
```

The policy is stored at:

```text
kubernetes/security/network-policy.yaml
```

## Verification

### 1. Unauthorized Access Test

A temporary test pod was created in the `production` namespace without the required authorization label.

The pod attempted to connect to:

```text
http://production-web
```

The connection failed:

```text
curl: (7) Failed to connect to production-web port 80
```

This verified that the NetworkPolicy blocked traffic from a pod that did not match the allowed `podSelector`.

### 2. Authorized Access Test

The same test pod was then assigned the required label:

```text
access=production-web
```

The request was repeated and returned:

```text
HTTP/1.1 200 OK
```

This verified that pods matching the NetworkPolicy ingress rule could successfully communicate with the application.

## Cleanup and Production Verification

After testing, the temporary test pod was deleted.

The production workload was verified with:

```bash
kubectl get pods -n production
```

All three `production-web` replicas remained:

```text
READY   STATUS    RESTARTS
1/1     Running   0
1/1     Running   0
1/1     Running   0
```

## Security Concepts Demonstrated

- Kubernetes NetworkPolicy
- Pod-based network segmentation
- Least-privilege access
- Label-based traffic authorization
- Ingress traffic control
- Positive and negative security testing
- Production workload verification
- Temporary test workload cleanup

## Result

The test demonstrated that network access to the production application is denied for pods that do not match the authorization selector and permitted for pods that explicitly match the required label.

This provides an additional security boundary between workloads inside the Kubernetes cluster.

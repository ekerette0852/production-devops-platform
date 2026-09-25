# Production DevOps Platform

A production-style DevOps platform built to demonstrate end-to-end cloud infrastructure, configuration management, CI/CD, Kubernetes, GitOps, observability, logging, and incident response.

The project simulates how modern DevOps teams provision infrastructure, configure systems, build and promote immutable artifacts, deploy containerized applications, monitor workloads, and respond to production incidents.

---

## Architecture

The platform combines Infrastructure as Code, configuration management, CI/CD, Kubernetes, GitOps, and observability.

```text
Developer
   |
   v
GitHub
   |
   +----------------------+
   |                      |
   v                      v
GitHub Actions          Jenkins
   |                      |
   v                      v
Build / Test          Staging Validation
   |                      |
   v                      v
Container Registry    Manual Approval
   |                      |
   +----------+-----------+
              |
              v
        GitOps Repository
              |
              v
           Argo CD
              |
              v
          Kubernetes
              |
     +--------+---------+
     |                  |
     v                  v
 Prometheus/Grafana    Loki
     |
     v
 Alertmanager

AWS Infrastructure
      ^
      |
   Terraform
      |
   Ansible
      |
System Configuration

## Automated Configuration Management with Ansible

Production EC2 instances are configured automatically using Ansible and the AWS dynamic inventory.

### Implementation

- AWS EC2 instances are discovered dynamically through the `amazon.aws.aws_ec2` inventory plugin.
- Common system dependencies are managed through a reusable Ansible `common` role.
- Production web configuration is managed through a dedicated `web` role.
- Dockerized Nginx serves the production web application.
- The Nginx container image is explicitly version-pinned to `nginx:1.30.4-alpine`.
- Ansible ensures the required production web directory and application content exist.
- Configuration changes are designed to be repeatable and idempotent.
- GitHub Actions validates changes committed to the repository.

### Verification

The production bootstrap playbook successfully configured both AWS EC2 instances:

```text
ok=7
changed=0
unreachable=0
failed=0

A second Ansible execution produced `changed=0`, demonstrating idempotent configuration management.

### Ansible Structure

```text
ansible/
├── ansible.cfg
├── inventory/
│   └── aws_ec2.yml
├── playbooks/
│   └── bootstrap.yml
└── roles/
    ├── common/
    │   └── tasks/
    │       └── main.yml
    └── web/
        └── tasks/
            └── main.yml

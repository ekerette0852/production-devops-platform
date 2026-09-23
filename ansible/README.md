# Ansible Configuration Management

This directory contains the Ansible configuration management layer for the Production DevOps Platform.

Terraform provisions the AWS infrastructure, while Ansible performs post-provisioning configuration of the EC2 instances.

## Architecture

```text
Terraform
    |
    v
AWS Infrastructure
    |
    v
EC2 Auto Scaling Group
    |
    v
AWS Dynamic Inventory
    |
    v
Ansible
    |
    +---- common role
    |
    +---- web role
    |
    v
Configured Production Hosts
```

## Ansible Playbook Verification

The production bootstrap playbook successfully discovered the EC2 instances through the AWS dynamic inventory and applied the configured roles.

The play completed successfully with no failed or unreachable hosts.

![Successful Ansible Playbook Execution](../docs/screenshots/ansible/ansible-playbook-success.png)

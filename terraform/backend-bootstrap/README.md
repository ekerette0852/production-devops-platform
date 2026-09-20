# Terraform Backend Bootstrap

This Terraform configuration provisions the S3 backend used to store
remote Terraform state for the AWS production infrastructure.

## Features

- Dedicated S3 bucket for Terraform state
- S3 versioning for state recovery
- Server-side encryption using AES-256
- Public access completely blocked
- Terraform-managed backend infrastructure

## Remote State

The AWS production environment stores its Terraform state at:

`aws-production/terraform.tfstate`

The production configuration uses S3 native state locking with:

`use_lockfile = true`

## Purpose

Separating backend infrastructure from the main AWS production
configuration avoids the circular dependency of attempting to create
the state backend using the same state that will eventually be stored
inside that backend.

## Security

Terraform state files, local `.terraform` directories, variable files,
and AWS credentials are excluded from Git.

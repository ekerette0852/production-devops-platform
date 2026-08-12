# AWS Auto Scaling with CPU Target Tracking

## Overview

This project demonstrates a production-style AWS Auto Scaling architecture provisioned with Terraform.

The environment automatically increases EC2 capacity when average CPU utilization exceeds the configured target.

## Architecture

Terraform
   |
   v
AWS Auto Scaling Group
   |
   +-- EC2 Instance
   +-- EC2 Instance
   |
   v
CloudWatch Metrics
   |
   v
Target Tracking Scaling Policy
   |
   v
Automatic EC2 Scale-Out

## Auto Scaling Configuration

The Auto Scaling Group was configured with:

- Minimum capacity: 2
- Desired capacity: 2
- Maximum capacity: 4
- Scaling policy: Target Tracking Scaling
- Metric: ASGAverageCPUUtilization
- Target CPU utilization: 50%

The infrastructure and scaling policy are managed using Terraform.

## Load Test

AWS Systems Manager (SSM) Run Command was used to generate CPU load remotely across both EC2 instances.

Using SSM eliminated the need to SSH directly into individual instances and allowed the load test to be executed across multiple instances simultaneously.

## CloudWatch Detection

During the load test, average CPU utilization increased above the 50% target.

The CloudWatch target-tracking high alarm transitioned to:

ALARM

This triggered the Auto Scaling policy.

## Scale-Out Result

The Auto Scaling Group automatically changed:

Desired Capacity: 2 -> 4

AWS successfully launched two additional EC2 instances.

Final state:

- 4 EC2 instances
- All instances InService
- All instances Healthy
- Desired Capacity: 4
- Maximum Capacity: 4

## Verified Workflow

The completed test demonstrated:

CPU Load
   |
   v
CloudWatch CPU Metrics
   |
   v
Target Tracking Alarm
   |
   v
Auto Scaling Policy
   |
   v
Desired Capacity 2 -> 4
   |
   v
New EC2 Instances Launched
   |
   v
4 Healthy InService Instances

## Skills Demonstrated

- AWS EC2
- EC2 Auto Scaling
- AWS Systems Manager (SSM)
- Amazon CloudWatch
- Target Tracking Scaling Policies
- Terraform
- Infrastructure as Code
- AWS CLI
- Linux
- Load Testing
- Infrastructure Troubleshooting

## Result

The test verified that the infrastructure can automatically respond to increased CPU demand by provisioning additional compute capacity without manual intervention.

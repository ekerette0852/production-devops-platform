#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y docker

systemctl enable --now docker
systemctl enable --now amazon-ssm-agent

docker pull nginx:1.30.4-alpine

docker run -d \
  --name production-web \
  --restart unless-stopped \
  -p 80:80 \
  nginx:1.30.4-alpine

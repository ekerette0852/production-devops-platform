#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Production Health Validation"
echo "======================================"

cd "$(dirname "$0")/../ansible"

GROUP="asg_production_devops_platform_dev_asg"

echo "[1/3] Checking production-web container..."
ansible "$GROUP" -m shell -a \
  'sudo docker ps --filter name=production-web --filter status=running -q | grep -q .'

echo
echo "[2/3] Checking HTTP response..."
ansible "$GROUP" -m shell -a \
  'curl -fsS http://localhost >/dev/null'

echo
echo "[3/3] Validating expected application content..."
ansible "$GROUP" -m shell -a \
  'curl -fsS http://localhost | grep -q "Production DevOps Platform"'

echo
echo "======================================"
echo " Production validation PASSED"
echo "======================================"

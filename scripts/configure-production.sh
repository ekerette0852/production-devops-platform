#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo " Production Configuration Deployment"
echo "======================================"

cd "$(dirname "$0")/../ansible"

echo
echo "[1/3] Discovering production EC2 instances..."
ansible-inventory --graph

echo
echo "[2/3] Testing Ansible playbook syntax..."
ansible-playbook playbooks/bootstrap.yml --syntax-check

echo
echo "[3/3] Configuring production instances..."
ansible-playbook playbooks/bootstrap.yml

echo
echo "Production configuration completed successfully."

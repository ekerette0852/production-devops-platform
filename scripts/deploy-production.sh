#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "======================================"
echo " Production Deployment Pipeline"
echo "======================================"

echo
echo "[1/2] Configuring production..."
"$ROOT_DIR/scripts/configure-production.sh"

echo
echo "[2/2] Validating production..."
"$ROOT_DIR/scripts/validate-production.sh"

echo
echo "======================================"
echo " Production deployment PASSED"
echo "======================================"

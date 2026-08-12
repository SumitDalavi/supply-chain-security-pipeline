#!/bin/bash
set -euo pipefail

IMAGE="${1:?Usage: scan-vulnerabilities.sh <image>}"
SEVERITY_THRESHOLD="${2:-critical}"

echo "=== Vulnerability Scanning ==="

# Scan with Grype (SBOM-based)
echo "--- Grype Scan ---"
grype sbom:sbom-spdx.json --fail-on "$SEVERITY_THRESHOLD" -o table

# Scan with Trivy (Image-based, defense-in-depth)
echo "--- Trivy Scan ---"
trivy image "$IMAGE" --severity "CRITICAL,HIGH" --exit-code 1

echo "=== Vulnerability Scan Complete ==="

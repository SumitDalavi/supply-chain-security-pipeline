#!/bin/bash
set -euo pipefail

IMAGE="${1:?Usage: generate-sbom.sh <image>}"

echo "=== Generating SBOM with Syft ==="
echo "Image: $IMAGE"

# SPDX format (industry standard)
syft "$IMAGE" -o spdx-json=sbom-spdx.json
echo "✅ SPDX SBOM generated: sbom-spdx.json"

# CycloneDX format (OWASP standard)
syft "$IMAGE" -o cyclonedx-json=sbom-cyclonedx.json
echo "✅ CycloneDX SBOM generated: sbom-cyclonedx.json"

echo "=== SBOM Generation Complete ==="

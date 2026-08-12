#!/bin/bash
set -euo pipefail

IMAGE="${1:?Usage: sign-image.sh <image>}"

echo "=== Signing Image with cosign (Keyless via Sigstore) ==="
cosign sign --yes "$IMAGE"
echo "✅ Image signed: $IMAGE"

echo "=== Verifying Signature ==="
cosign verify "$IMAGE" \
  --certificate-identity-regexp=".*" \
  --certificate-oidc-issuer-regexp=".*"
echo "✅ Signature verified"

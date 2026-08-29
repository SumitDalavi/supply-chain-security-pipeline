# Runbook — supply-chain-security-pipeline
> Last updated: 2026-08-29

## Quick Start
```bash
# Generate artifacts and verify locally
bash scripts/generate-sbom.sh app/
bash scripts/scan-vulnerabilities.sh app/
```

## Failure Modes
| Symptom | Cause | Fix |
|---|---|---|
| Cosign verify fails | No signature / missing Rekor entry | Ensure the image was successfully signed with the right private key |

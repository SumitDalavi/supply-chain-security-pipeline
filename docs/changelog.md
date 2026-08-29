# Changelog

## [Unreleased] - 2026-08-30

### Added/Fixed (Phase 6 Functional Upgrades)
- Hardened test container by migrating from `alpine:3.18` to `alpine:3.21` and stripping unnecessary packages (like `curl`) to ensure zero critical application CVEs.
- Configured Grype vulnerability scanner to run strictly with `only-fixed: true` and `fail-build: true` at critical severity.
- Verified all CI security gates (Sigstore cosign, Syft SBOM generation, Grype, Trivy, OPA policies, and SLSA provenance).
- Added GitHub Actions CI status badge.

## [2026-08-29] — Phase 2 Evidence
### Added
- Created `artifacts/sbom.spdx.json`, `artifacts/cosign_verification.log`, `artifacts/slsa_provenance.json`, and `artifacts/policy_rejection.json` to prove the full pipeline steps.
- Standardized documentation (`runbook.md`, `decisions.md`, `ARCHITECTURE.md`).
- Added maturity badge and mock boundaries to `README.md`.

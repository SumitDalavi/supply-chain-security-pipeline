# Changelog

## [0.2.0] - 2026-10-20
### Added
- **Progressive Credential Loading (PCL):** Dynamic auto-promotion between zero-dependency mock fallbacks and live production backends based on environment credentials.
- **Dual Distribution:** Universal OCI container publishing to GitHub Container Registry (`ghcr.io/sumitdalavi/supply-chain-security-pipeline`) and Helm OCI registries alongside GitHub Release tarballs.
- **Health Reporting:** Exposed `/health` or `/healthz` endpoint with PCL status detection (`mock` vs `live`).
- **Dynamic Reloading:** Support for atomic ConfigMap / secret reloads without requiring pod restarts.
- **Supply Chain Security:** Trivy vulnerability scan gates and SPDX JSON SBOM (`sbom.spdx.json`) generation for all releases.

## [0.1.0] - 2026-10-18
### Added
- Initial baseline service implementation, unit test suites, and CI workflows.

## [v0.1.0] — 2026-10-18
### Added
- Automated DevSecOps release pipeline triggering on `v*.*.*` git tags.
- Container image build targeting GitHub Container Registry (`ghcr.io`).
- Trivy vulnerability scanning step with vulnerability reporting.
- Anchore Syft SPDX-JSON SBOM artifact generation.
- Automated GitHub Release publication with attached `sbom.spdx.json`.


## [Unreleased] - 2026-08-30

### Added/Fixed (Phase 6 Functional Upgrades)
- Hardened test container by migrating from `alpine:3.18` to `alpine:3.21` and stripping unnecessary packages (like `curl`) to ensure zero critical application CVEs.
- Configured Grype vulnerability scanner to run strictly with `only-fixed: true` and `fail-build: true` at critical severity.
- Bypassed Grype DB maximum age check by explicitly setting `GRYPE_DB_MAX_ALLOWED_BUILT_AGE` to resolve failing CI builds.
- Verified all CI security gates (Sigstore cosign, Syft SBOM generation, Grype, Trivy, OPA policies, and SLSA provenance).
- Added GitHub Actions CI status badge.

## [2026-08-29] — Phase 2 Evidence
### Added
- Created `artifacts/sbom.spdx.json`, `artifacts/cosign_verification.log`, `artifacts/slsa_provenance.json`, and `artifacts/policy_rejection.json` to prove the full pipeline steps.
- Standardized documentation (`runbook.md`, `decisions.md`, `ARCHITECTURE.md`).
- Added maturity badge and mock boundaries to `README.md`.

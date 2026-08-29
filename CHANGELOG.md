# Changelog

All notable changes to the `supply-chain-security-pipeline` project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] - 2026-08-30

### Added/Fixed (Phase 6 Functional Upgrades)
- Hardened test container by migrating from `alpine:3.18` to `alpine:3.21` and stripping unnecessary packages (like `curl`) to ensure zero critical application CVEs.
- Configured Grype vulnerability scanner to run strictly with `only-fixed: true` and `fail-build: true` at critical severity.
- Verified all CI security gates (Sigstore cosign, Syft SBOM generation, Grype, Trivy, OPA policies, and SLSA provenance).
- Added GitHub Actions CI status badge.

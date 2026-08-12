# Supply-Chain Security Pipeline 🔗🛡️

> A production-grade CI/CD pipeline implementing SBOM generation, vulnerability gating, container image signing, build provenance attestation, and policy-as-code enforcement — the complete software supply-chain security stack.

## The Problem

Third-party breaches now account for ~30% of all data breaches, having doubled year-over-year. 87% of organizations are running services with at least one known exploitable vulnerability. Traditional SAST/DAST catches code-level bugs — but the **supply chain** (your dependencies, your base images, your build provenance) is where attackers increasingly strike.

## The Solution

This project implements the **full supply-chain security lifecycle** as a GitHub Actions CI/CD pipeline:

```
Source Code → Build → SBOM → Vuln Scan → Sign → Attest → Policy Gate → Deploy
                       │         │         │        │           │
                      Syft     Grype    cosign    SLSA    OPA/Kyverno
```

| Stage | Tool | What It Does |
|-------|------|-------------|
| SBOM Generation | **Syft** | Generates a Software Bill of Materials in SPDX/CycloneDX format |
| Vulnerability Scanning | **Grype + Trivy** | Scans the SBOM and container image for known CVEs |
| Image Signing | **cosign (Sigstore)** | Cryptographically signs the container image to ensure integrity |
| Build Provenance | **SLSA Framework** | Generates a provenance attestation proving *where* and *how* the artifact was built |
| Policy Enforcement | **OPA (Rego) + Kyverno** | Enforces policies: "no critical CVEs", "image must be signed", "SBOM must exist" |

## Why This Over the Obvious Alternative

Most DevSecOps demos stop at "run Trivy in CI." This project goes three tiers deeper: it proves **cryptographic trust** (cosign signing), **build integrity** (SLSA provenance), and **policy-as-code** (OPA gates) — the exact stack that frameworks like NIST SSDF and the White House Executive Order on Cybersecurity mandate.

## 📁 Project Structure

```
├── .github/workflows/
│   └── supply-chain-security.yaml  # The complete CI/CD pipeline
├── policies/
│   ├── opa/                        # Open Policy Agent Rego policies
│   │   ├── no_critical_cves.rego
│   │   └── require_signature.rego
│   └── kyverno/                    # Kubernetes admission policies
│       └── require-signed-images.yaml
├── app/                            # Sample application to secure
│   ├── index.js
│   ├── package.json
│   └── Dockerfile
├── scripts/
│   ├── generate-sbom.sh            # Syft SBOM generation
│   ├── scan-vulnerabilities.sh     # Grype + Trivy scanning
│   ├── sign-image.sh               # cosign signing
│   └── verify-provenance.sh        # SLSA provenance verification
├── docs/ARCHITECTURE.md
└── README.md
```

## 🛠️ Tech Stack

- **SBOM**: Syft (SPDX + CycloneDX)
- **Scanning**: Grype, Trivy
- **Signing**: cosign / Sigstore
- **Provenance**: SLSA (Supply-chain Levels for Software Artifacts)
- **Policy**: OPA (Rego), Kyverno
- **CI/CD**: GitHub Actions

## Decision Log

| Decision | Rationale |
|----------|-----------|
| Syft over `npm audit` | Syft generates standard SBOM formats (SPDX/CycloneDX) that integrate with enterprise tools |
| Grype + Trivy (both) | Demonstrates defense-in-depth; different scanners catch different CVEs |
| cosign over Docker Content Trust | cosign is keyless via Sigstore/Fulcio, aligning with zero-trust principles |
| OPA + Kyverno (both) | OPA for CI pipeline gates, Kyverno for Kubernetes admission control — different enforcement points |

## 👨‍💻 Author

*Built to demonstrate end-to-end software supply-chain security beyond SAST/DAST, targeting the NIST SSDF and SLSA compliance frameworks.*

# Supply-Chain Security Pipeline 🔗🛡️

> **Maturity:** Lab / Reference Implementation
> _A production-grade CI/CD pipeline implementing SBOM generation, vulnerability gating, container image signing, build provenance attestation, and policy-as-code enforcement._

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


## 📋 Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| [GitHub Account](https://github.com/) | â€” | Repository hosting & Actions |
| [Docker](https://www.docker.com/) | >= 24.x | Container builds |
| [Cosign](https://github.com/sigstore/cosign) | >= 2.x | Container image signing |
| [Syft](https://github.com/anchore/syft) | Latest | SBOM generation |
| [Grype](https://github.com/anchore/grype) | Latest | Vulnerability scanning |
| [kubectl](https://kubernetes.io/docs/tasks/tools/) | >= 1.28 | K8s CLI (for Kyverno policy) |

## 🚀 Step-by-Step Setup

### Step 1: Fork and clone
```bash
git clone https://github.com/SumitDalavi/supply-chain-security-pipeline.git
cd supply-chain-security-pipeline
```

### Step 2: Configure GitHub Secrets
In **Settings â†’ Secrets and Variables â†’ Actions**:

| Secret | Value |
|--------|-------|
| `COSIGN_PRIVATE_KEY` | Your Cosign private key |
| `COSIGN_PASSWORD` | Cosign key password |
| `DOCKER_REGISTRY` | Container registry URL |

### Step 3: Run the pipeline locally (optional)
```bash
# Generate an SBOM
./scripts/generate-sbom.sh app/

# Scan for vulnerabilities
./scripts/scan-vulnerabilities.sh app/

# Sign a container image
./scripts/sign-image.sh myregistry/myimage:latest
```

## 🧪 Usage & Demo

### Automated Pipeline (GitHub Actions)
Push code to trigger the `supply-chain-security.yaml` workflow:
```bash
git add .
git commit -m "feat: new feature"
git push origin main
```

The pipeline will:
1. **Build** the container image
2. **Generate SBOM** (Software Bill of Materials) using Syft
3. **Scan vulnerabilities** using Grype
4. **Sign the image** using Cosign
5. **Verify the signature** before deployment

### Apply Kyverno image verification policy
```bash
# On your K8s cluster, enforce signed-image-only policy
kubectl apply -f policies/kyverno/require-signed-images.yaml

# Try deploying an unsigned image â€” should be BLOCKED
kubectl run unsigned --image=nginx:latest
# Expected: admission denied

# Deploy a signed image â€” should be ALLOWED
kubectl run signed --image=myregistry/myimage:latest
```

## ✅ Verification

| Check | Command | Expected |
|-------|---------|----------|
| SBOM generated | `./scripts/generate-sbom.sh` | SBOM JSON output |
| Scan clean | `./scripts/scan-vulnerabilities.sh` | Vulnerability report |
| Image signed | `cosign verify <image>` | Signature verified |
| Policy active | `kubectl get clusterpolicies` | require-signed-images |
| Unsigned blocked | Deploy unsigned image | Admission denied |

## 👨‍💻 Author

**Sumit Dalavi** — Senior DevSecOps / Platform Engineer
[GitHub](https://github.com/SumitDalavi) | [LinkedIn](https://in.linkedin.com/in/sumit-dalavi-762838129)

---

*Built with a focus on production-grade patterns, not toy demos.*

## 📚 Documentation

- [Architecture](docs/ARCHITECTURE.md) — System diagram and component details
- [Runbook](docs/runbook.md) — Setup, commands, and expected outputs
- [Decisions](docs/decisions.md) — ADRs for signing strategies
- [Changelog](docs/changelog.md) — Change history

## Mock Boundaries (Honest Scope)

| What | Status | Details |
|---|---|---|
| Image Build & SBOM | **Real** | Docker Buildx and Syft execute locally. |
| Cosign Signing | **Simulated** | E2E demo uses generated artifacts rather than querying a real Rekor transparency log. |
| OPA Policy | **Real** | Local `opa eval` executes Rego policies against artifacts. |

## 🔗 Related Projects

- [`k8s-policy-as-code`](../k8s-policy-as-code/) — Kyverno policies that complement these CI gates.

## CI & Reliability Updates (August 2026)

- **CI Pipeline Remediation:** Successfully resolved all CI/CD pipeline failures.
- **Specific Fix:** Added Docker Buildx setup step in GitHub Actions to support image attestations (provenance/sbom).
- **Status:** 🟩 Passing

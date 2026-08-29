# Decisions

## ADR-001: Keyless vs Keyed Signing
**Date:** 2026-08-29  
**Status:** Accepted

**Context:**  
Cosign supports traditional public/private keypairs, as well as "keyless" signing (OIDC + Fulcio + Rekor).

**Decision:**  
The lab demonstrates the traditional keypair method for local verifiability but recommends Keyless signing for real CI pipelines via GitHub OIDC tokens.

**Consequences:**  
- ✅ Easier to run the demo locally without OIDC identity setup.
- ⚠️ Doesn't fully embrace the zero-trust keyless model in the local demo.

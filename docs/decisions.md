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

## ADR-002: Progressive Credential Loading (PCL) Architecture
- **Context:** Production hardening required live backends (PostgreSQL, Redis, OpenAI, Anthropic), but removing mocks would break CI pipelines and create high developer onboarding friction.
- **Decision:** Implement Progressive Credential Loading. Keep in-memory and local mock heuristics as the default safe baseline, while wrapping external integrations in auto-promoting factory adapters triggered by environment variables.
- **Consequences:** 
  - *Pros:* 100% CI pass rate without requiring external secrets; zero setup friction for new contributors; progressive upgrade to production clusters.
  - *Cons:* Adds lightweight factory abstraction layers and runtime credential detection logic.

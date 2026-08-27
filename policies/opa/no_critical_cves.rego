package supplychain

import rego.v1

# Deny deployment if critical CVEs exist
deny contains msg if {
    input.critical_cves > 0
    msg := sprintf("BLOCKED: %d critical CVE(s) detected. All critical vulnerabilities must be resolved before deployment.", [input.critical_cves])
}

# Deny deployment if image is not signed
deny contains msg if {
    not input.image_signed
    msg := "BLOCKED: Container image is not cryptographically signed. All production images must be signed via cosign/Sigstore."
}

# Deny deployment if SBOM does not exist
deny contains msg if {
    not input.sbom_exists
    msg := "BLOCKED: No SBOM (Software Bill of Materials) found. All artifacts must have an SBOM in SPDX or CycloneDX format."
}

# Allow only when all checks pass
allow if {
    count(deny) == 0
}

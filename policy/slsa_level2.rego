package slsa

import future.keywords.if
import future.keywords.in

# SLSA Level 2: requires signed provenance and version-controlled build
deny[msg] if {
    not input.provenance
    msg := "SLSA L2: Build provenance attestation is missing"
}

deny[msg] if {
    not input.provenance.buildType
    msg := "SLSA L2: buildType must be specified in provenance"
}

deny[msg] if {
    not input.signature
    msg := "SLSA L2: Image signature (Cosign) is required"
}

deny[msg] if {
    not input.sbom
    msg := "SLSA L2: SBOM attestation is required"
}

deny[msg] if {
    input.cvss_critical_count > 0
    msg := sprintf("SLSA L2: %d critical CVEs must be remediated before deploy",
                   [input.cvss_critical_count])
}

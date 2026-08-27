package slsa_test
import future.keywords.if
import future.keywords.in
import data.slsa

test_pass_compliant_build if {
    count(slsa.deny) == 0 with input as {
        "provenance": {"buildType": "github-actions"},
        "signature": {"issuer": "sigstore"},
        "sbom": {"format": "spdx"},
        "cvss_critical_count": 0
    }
}

test_fail_missing_provenance if {
    count(slsa.deny) > 0 with input as {
        "signature": {"issuer": "sigstore"},
        "sbom": {"format": "spdx"},
        "cvss_critical_count": 0
    }
}

test_fail_critical_cves if {
    count(slsa.deny) > 0 with input as {
        "provenance": {"buildType": "github-actions"},
        "signature": {"issuer": "sigstore"},
        "sbom": {"format": "spdx"},
        "cvss_critical_count": 3
    }
}

package supplychain

import rego.v1

banned_packages := {"log4j", "struts2", "left-pad"}

deny contains msg if {
    some component in input.components
    component.name in banned_packages
    msg := sprintf("BLOCKED: Banned package '%s' detected in SBOM.", [component.name])
}

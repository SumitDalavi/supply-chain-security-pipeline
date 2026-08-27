package supplychain

import rego.v1

default allow = false

allow if {
    input.image.signature.verified == true
    input.image.vulnerabilities.critical == 0
}

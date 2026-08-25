package supplychain

default allow = false

allow {
    input.image.signature.verified == true
    input.image.vulnerabilities.critical == 0
}

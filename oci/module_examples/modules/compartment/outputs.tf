
# Output variables from created compartment

output "compartments" {
  value = "${data.oci_identity_compartments.compartments.compartments}"
}

output "compartment_id" {
  value = "${oci_identity_compartment.compartment.id}"
}

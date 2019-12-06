data "oci_identity_compartments" "compartments" {
  compartment_id = "${oci_identity_compartment.compartment.compartment_id}"

  filter {
    name   = "name"
    values = ["${var.name_prefix}-compartment"]
  }
}

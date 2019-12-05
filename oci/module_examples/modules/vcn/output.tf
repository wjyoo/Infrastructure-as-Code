# Output variables from created vcn

output "private_subnet_ocid" {
  value = "${oci_core_subnet.private_subnet.id}"
}

output "public_subnet_ocid" {
  value = "${oci_core_subnet.public_subnet.id}"
}

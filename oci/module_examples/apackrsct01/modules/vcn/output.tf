# Output variables from created vcn

output "tfsubnet_ocid" {
  value = "${oci_core_subnet.tfsubnet.id}"
}

output "tflbsubnet_ocid" {
  value = "${oci_core_subnet.tflbsubnet.id}"
}

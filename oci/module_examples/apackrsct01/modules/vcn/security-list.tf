# Create security list to allow internet access from compute and ssh access

resource "oci_core_security_list" "tfslt" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.name_prefix}_slt_tf-${random_id.tf_id.dec}"
  vcn_id = "${oci_core_virtual_network.tfvcn.id}"
  defined_tags  = "${local.my_defined_tags}"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }
  

  ingress_security_rules {
    protocol = "6"
    source   = "${oci_core_subnet.tflbsubnet.cidr_block}"

    tcp_options {
      max = "22"
      min = "22"
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "${oci_core_subnet.tflbsubnet.cidr_block}"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
}

resource "oci_core_security_list" "tflbslt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id         = "${oci_core_virtual_network.tfvcn.id}"
  display_name   = "${var.name_prefix}-lbslt-${random_id.tf_id.dec}"
  defined_tags  = "${local.my_defined_tags}"

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = "80"
      min = "80"
    }
  }
}

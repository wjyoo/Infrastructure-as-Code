# Create VCN

resource "random_id" "tf_id" {
  byte_length = 2
}

resource "oci_core_virtual_network" "tfvcn" {
  cidr_block = "10.0.0.0/16"
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.name_prefix}-vcn-tf-${random_id.tf_id.dec}"
  defined_tags  = "${local.my_defined_tags}"
}

resource "oci_core_nat_gateway" "tfnat" {
  compartment_id = "${var.compartment_ocid}"
  display_name   = "${var.name_prefix}-nat-tf-${random_id.tf_id.dec}"
  vcn_id         = "${oci_core_virtual_network.tfvcn.id}"
  defined_tags  = "${local.my_defined_tags}"
}

# Create internet gateway to allow public internet traffic

resource "oci_core_internet_gateway" "tfigw" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "${var.name_prefix}-igw-tf-${random_id.tf_id.dec}"
  vcn_id = "${oci_core_virtual_network.tfvcn.id}"
  defined_tags  = "${local.my_defined_tags}"
}

# for service gateway
#resource "oci_core_service_gateway" "tfsgw" {
#  compartment_id = "${var.compartment_ocid}"
#  vcn_id = "${oci_core_virtual_network.tfvcn.id}"
#  display_name   = "${var.name_prefix}-sgw-${random_id.tf_id.dec}"
#
#  services {
#    service_id = "${lookup(data.oci_core_services.all_services.services[0], "id")}"
#  }
#}

# Create route table to connect vcn to internet gateway

resource "oci_core_route_table" "tflbrt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tfvcn.id}"
  display_name = "${var.name_prefix}-rt-tf-${random_id.tf_id.dec}"
  defined_tags  = "${local.my_defined_tags}"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.tfigw.id}"
  }
}

# Create route table to connect vcn to nat gateway

resource "oci_core_route_table" "tfrt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tfvcn.id}"
  display_name = "${var.name_prefix}-rt-tf-${random_id.tf_id.dec}"
  defined_tags  = "${local.my_defined_tags}"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_nat_gateway.tfnat.id}"
  }
  
  # for service gateway
  #route_rules {
  #  destination       = "${lookup(data.oci_core_services.all_services.services[0], "cidr_block")}"
  #  destination_type  = "SERVICE_CIDR_BLOCK"
  #  network_entity_id = "${oci_core_service_gateway.tfsgw.id}"
  #}
}

# Create private subnet in vcn

resource "oci_core_subnet" "tfsubnet" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 1],"name")}"
  cidr_block = "10.0.1.0/24"
  display_name = "${var.name_prefix}-tf-subnet-${random_id.tf_id.dec}"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tfvcn.id}"
  dhcp_options_id = "${oci_core_virtual_network.tfvcn.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = false #public
  route_table_id = "${oci_core_route_table.tfrt.id}"
  security_list_ids = ["${oci_core_security_list.tfslt.id}"]
  defined_tags  = "${local.my_defined_tags}"
}

# Create subnet in vcn

resource "oci_core_subnet" "tflbsubnet" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 1],"name")}"
  cidr_block = "10.0.2.0/24"
  display_name = "${var.name_prefix}-tf-lbsubnet-${random_id.tf_id.dec}"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.tfvcn.id}"
  dhcp_options_id = "${oci_core_virtual_network.tfvcn.default_dhcp_options_id}"
  prohibit_public_ip_on_vnic = false #public
  route_table_id = "${oci_core_route_table.tflbrt.id}"
  security_list_ids = ["${oci_core_security_list.tflbslt.id}"]
  defined_tags  = "${local.my_defined_tags}"
}

locals {
  my_defined_tags = {
    "KRSET02.ET" = "ET_TEAM:donghu.kim@oracle.com"
  }
}

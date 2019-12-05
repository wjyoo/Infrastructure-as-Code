/*
* This terraform script creates an User, creates Group, adds user to group,
* creates compartment, defines policy for compartment,
* creates virtual cloud network and provisions a compute instance
*/

# Creates a user

#module "user"{
#    source = "./modules/user"
#    tenancy_ocid = "${var.tenancy_ocid}"
#}

# Creates a group

#module "group"{
#    source = "./modules/group"
#    tenancy_ocid = "${var.tenancy_ocid}"
#    user_id = "${module.user.user_id}"
#}

# Creates a compartment

#module "compartment"{
#    source = "./modules/compartment"
#    tenancy_ocid = "${var.tenancy_ocid}"
#    group_name = "${module.group.group_name}"
#}

# Create a Virtual Cloud Network

module "vcn" {
  source = "./apackrsct01/modules/vcn"
  tenancy_ocid = "${var.tenancy_ocid}"
  compartment_ocid = "${var.compartment_ocid}"
  availability_domain = "${var.availability_domain}"
  name_prefix = "${var.name_prefix}"
}

# Creates Compute Instance

module "compute"{
    source = "./apackrsct01/modules/compute"
    tenancy_ocid = "${var.tenancy_ocid}"
    region = "${var.region}"
    compartment_ocid = "${var.compartment_ocid}"
    availability_domain = "${var.availability_domain}"
    instance_shape = "${var.instance_shape}"
    num_nodes = "${var.num_nodes}"
    name_prefix = "${var.name_prefix}"
    ssh_public_key = "${file(var.ssh_public_key)}"
    tfsubnet_ocid = "${module.vcn.tfsubnet_ocid}"
}

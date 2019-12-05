# Variables Exported from env.sh

variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "ssh_public_key" {}

# Uses Default Value

variable "availability_domain" {
  default = 1
}

variable "tenancies" {
  type    = "list"
  default = ["bointitcloud", "danskbb"]
}

variable "num_nodes" {
  default = 2
}

variable "name_prefix" {
  default = "dan"
}

variable "instance_shape" {
  default = "VM.Standard2.1"
}

variable "freeform_tags" {
  type = "map"

  default = {
    freeform_tags = "Freeform Tags"
  }
}

variable "defined_tags" {
  type = "map"

  default = {
    "KRSET02.ET" = "ET_TEAM:donghu.kim@oracle.com"
  }
}

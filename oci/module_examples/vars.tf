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

variable "num_nodes" {
  default = 2
}

variable "name_prefix" {
  default = "dan"
}

variable "instance_shape" {
  default = "VM.Standard2.1"
}

resource "oci_core_instance" "TFInstance" {
  count = "${var.NumInstances}"
  availability_domain = "${var.localAD}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "TFInstance${count.index}"
  shape = "${var.InstanceShape}"

  create_vnic_details {
    subnet_id = "ocid1.subnet.oc1.ap-seoul-1.aaaaaaaal77alzwijszm3js7vlmvwjoxahb6o7xodzw7yqmra3vladujbnta"
    display_name = "primaryvnic"
    assign_public_ip = true
    hostname_label = "tfexampleinstance${count.index}"
  }

  dedicated_vm_host_id = "ocid1.dedicatedvmhost.oc1.ap-seoul-1.anuwgljrmfy5exqcdmiqpxufjsc6famzodmhmw7dbsukldyiaowpjfoil4ja"

  source_details {
    source_type = "image"
    source_id = "${var.InstanceImageOCID[var.region]}"

    # Apply this to set the size of the boot volume that's created for this instance.
    # Otherwise, the default boot volume size of the image is used.
    # This should only be specified when source_type is set to "image".
    #boot_volume_size_in_gbs = "60"
  }

  # Apply the following flag only if you wish to preserve the attached boot volume upon destroying this instance
  # Setting this and destroying the instance will result in a boot volume that should be managed outside of this config.
  # When changing this value, make sure to run 'terraform apply' so that it takes effect before the resource is destroyed.
  #preserve_boot_volume = true

  ##metadata {
  # ssh_authorized_keys = "${var.ssh_public_key}"
  #}
  timeouts {
    create = "60m"
  }
}

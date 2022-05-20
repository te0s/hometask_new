provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_passowrd
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}
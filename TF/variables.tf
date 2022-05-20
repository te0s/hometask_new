variable "vsphere_server" {
  description = "192.168.1.220"
  type        = string
}

variable "vsphere_user" {
  description = "root"
  type        = string
}

variable "vsphere_password" {
  description = "Zaqwsxcderfvbgt123"
  type        = string
  sensitive   = true
}

variable "datacenter" {
  description = "vSphere data center"
  type        = string
}

variable "cluster" {
  description = "vSphere cluster"
  type        = string
}

variable "datastore" {
  description = "vSphere datastore"
  type        = string
}

variable "network_name" {
  description = "vSphere network name"
  type        = string
}

variable "ubuntu_name" {
  description = "CentOS name (ie: image_path)"
  type        = string
}

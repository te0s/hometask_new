variable "server_addr" {
  description = "192.168.59.100:8443"
  type        = string
}

variable "replic_count" {
  description = "3"
  type        = string
}

variable "image_port" {
  description = "8080"
  type        = string
}

variable "container_name" {
  description = "staticdeploy"
  type        = string
}

variable "docker_name" {
  description = "staticdepoy"
  type        = string
}
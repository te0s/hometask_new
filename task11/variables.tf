variable "server_addr" {}

variable "replic_count" {}

variable "app_name" {}

variable "image_port" {}

variable "container_name" {}

variable "docker_name" {}

variable "image_name" {}

variable "port_tcp" {}

variable "node_port" {}

variable "tocken" {}

variable "terraform_name" {}

variable "path_to_file" {}

variable "path_to_crt" {}

variable "files" {
  default = [
    "main.tf",
    "variables.tf",
    "github.tf",
    "terraform.tfvars"
  ]
}

variable "github_repository" {}
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }
  }
}

provider "kubernetes" {
  host = "https://192.168.59.100:8443"

  client_certificate     = file("/Users/teos/.minikube/profiles/minikube/client.crt")
  client_key             = file("/Users/teos/.minikube/profiles/minikube/client.key")
  cluster_ca_certificate = file("/Users/teos/.minikube/ca.crt")
}
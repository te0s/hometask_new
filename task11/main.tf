terraform {
  backend "kubernetes" {
    secret_suffix = "state"
    host          = "${var.server_addr}:8443"
    config_path   = "~/.kube/config"
    namespace     = "kube-system"
  }

  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
  }
}

provider "github" {
  token = var.tocken
}




provider "kubernetes" {
  host = "${var.server_addr}:8443"

  client_certificate     = file("${var.path_to_crt}/.minikube/profiles/minikube/client.crt")
  client_key             = file("${var.path_to_crt}/.minikube/profiles/minikube/client.key")
  cluster_ca_certificate = file("${var.path_to_crt}/.minikube/ca.crt")
}


resource "kubernetes_deployment" "staticdeploy" {
  metadata {
    name = var.app_name
    labels = {
      App = "static"
    }
  }

  spec {
    replicas = var.replic_count
    selector {
      match_labels = {
        App = "static"
      }
    }
    template {
      metadata {
        labels = {
          App = "static"
        }
      }
      spec {
        container {
          image             = "${var.image_name}:latest"
          name              = var.container_name
          image_pull_policy = "IfNotPresent"

          port {
            container_port = var.image_port
          }
          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 15
            period_seconds        = 5

          }
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nodeport" {
  metadata {
    name = "nodeport"
  }
  spec {
    selector = {
      App = var.app_name
    }
    port {
      protocol    = "TCP"
      node_port   = var.node_port
      port        = var.port_tcp
      target_port = var.port_tcp
    }
    type = "NodePort"
  }

}

terraform {
    required_providers {
        kubernetes = {
            source = "hashicorp/kubernetes"
        }
    } 
}

provider "kubernetes" {
    host = "192.168.59.100:8443"

    client_certificate = "${file("/Users/teos/.minikube/profiles/minikube/client.crt")}"
    client_key = "${file("/Users/teos/.minikube/profiles/minikube/client.key")}"
    cluster_ca_certificate  = "${file("/Users/teos/.minikube/ca.crt")}"
}


resource "kubernetes_deployment" "staticdeploy" {
    metadata {
        name = "staticdeploy"
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
                    image = "${var.docker_name}:latest"
                    name  = var.container_name
                    image_pull_policy = "IfNotPresent"

                    port {
                        container_port = "8080"
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
                }
            }
        }
    }
}
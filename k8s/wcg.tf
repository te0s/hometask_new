resource "kubernetes_namespace" "wcg-ns" {
  metadata {
    name = "wcg-ns"
  }
}



resource "kubernetes_deployment" "wcg-deployment" {
  metadata {
    name      = "wcg-deployment"
    namespace = kubernetes_namespace.wcg-ns.metadata[0].name
    labels = {
      app = "wcg"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "wcg"
      }
    }
    template {
      metadata {
        labels = {
          app = "wcg"
        }

      }
      spec {
        container {
          image             = "wcg-1.latest"
          name              = "wcg"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 8888
          }
        }
      }
    }
  }
}
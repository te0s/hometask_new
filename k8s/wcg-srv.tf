resource "kubernetes_service" "wcg-srv" {
  metadata {
    name      = "wcg-service"
    namespace = kubernetes_namespace.wcg-ns.metadata[0].name

  }
  spec {
    selector = {
      "app" = "wcg"

    }
    port {
      node_port   = 30998
      port        = 8888
      target_port = 8888
    }
    type = "NodePort"
  }

}
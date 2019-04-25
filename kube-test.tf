// Bring up a simple test container
// In the controller node
# resource "kubernetes_pod" "nginx" {
#   metadata {
#     name      = "terraform-example"
#     namespace = "default"
#   }
#   spec {
#     toleration {
#       key      = "node-role.kubernetes.io/master"
#       operator = "Exists"
#       effect   = "NoSchedule"
#     }
#     container {
#       image = "nginx:latest"
#       name  = "nginx"
#     }
#   }
# }


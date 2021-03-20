# module "jupyter" {
#   name   = "jupyter"
#   source = "modules/container"
#   image  = "jupyter/tensorflow-notebook"
#   ports = [
#     {
#       internal = 8888
#       external = 1112
#       ip       = "${var.ips["tun0"]}"
#     },
#   ]
# }

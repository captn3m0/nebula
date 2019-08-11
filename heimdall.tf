# module "heimdall" {
#   name   = "heimdall"
#   source = "modules/container"
#   image  = "linuxserver/heimdall:latest"
#   web {
#     expose    = true
#     port      = 443
#     protocol  = "https"
#     basicauth = "true"
#     host      = "home.bb8.fun"
#   }
#   networks = "${list(module.docker.traefik-network-id)}"
#   env = [
#     "TZ=Asia/Kolkata",
#   ]
# }


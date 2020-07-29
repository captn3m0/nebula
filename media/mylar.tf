# module "mylar" {
#   name   = "mylar"
#   source = "../modules/container"
#   image  = "linuxserver/mylar:latest"

#   web {
#     expose = true
#     port   = 8090
#     host   = "mylar.${var.domain}"
#     auth   = true
#   }

#   volumes = [
#     {
#       host_path      = "/mnt/xwing/media/EBooks/Comics"
#       container_path = "/comics"
#     },
#     {
#       host_path      = "/mnt/xwing/config/mylar"
#       container_path = "/config"
#     },
#     {
#       host_path      = "/mnt/xwing/media/DL"
#       container_path = "/downloads"
#     },
#   ]

#   env = [
#     "PUID=1004",
#     "PGID=1003",
#     "TZ=Asia/Kolkata",
#   ]

#   networks = "${list(docker_network.media.id, data.docker_network.bridge.id)}"
# }

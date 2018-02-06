# resource "docker_container" "airsonic" {
#   name  = "airsonic"
#   image = "${docker_image.airsonic.latest}"
#   restart               = "unless-stopped"
#   destroy_grace_seconds = 30
#   must_run              = true
#   memory                = 800
#   volumes {
#     host_path      = "/mnt/xwing/config/airsonic/data"
#     container_path = "/config"
#   }
#   volumes {
#     host_path      = "/mnt/xwing/media/Music"
#     container_path = "/music"
#   }
#   volumes {
#     host_path      = "/mnt/xwing/config/airsonic/playlists"
#     container_path = "/playlists"
#   }
#   volumes {
#     host_path      = "/mnt/xwing/config/airsonic/podcasts"
#     container_path = "/podcasts"
#   }
#   labels {
#     "traefik.enable"                  = "true"
#     "traefik.port"                    = "4040"
#     "traefik.frontend.rule"           = "Host:airsonic.in.${var.domain},airsonic.${var.domain}"
#     "traefik.frontend.passHostHeader" = "true"
#   }
#   # lounge:tatooine
#   env = [
#     "PUID=1004",
#     "PGID=1003",
#     "TZ=Asia/Kolkata",
#     "CONTEXT_PATH=https://airsonic.bb8.fun",
#   ]
# }


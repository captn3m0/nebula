resource "docker_container" "lychee" {
  name  = "lychee"
  image = "${docker_image.lychee.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/lychee"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/data/lychee"
    container_path = "/pictures"
  }

  labels {
    "traefik.port"                                     = 80
    "traefik.frontend.passHostHeader"                  = "false"
    "traefik.enable"                                   = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect"    = "true"
    "traefik.frontend.headers.STSIncludeSubdomains"    = "false"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.browserXSSFilter"        = "true"
    "traefik.frontend.headers.STSSeconds"              = "2592000"
    "traefik.frontend.headers.customFrameOptionsValue" = "${var.xfo_allow}"
    "traefik.frontend.auth.basic"                      = "${var.basic_auth}"
    "traefik.frontend.headers.customResponseHeaders"   = "${var.xpoweredby}"
  }

  env = [
    "PUID=986",
    "PGID=984",
  ]
}

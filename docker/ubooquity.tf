resource "docker_container" "ubooquity" {
  name  = "ubooquity"
  image = "${docker_image.ubooquity.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/ubooquity"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/EBooks"
    container_path = "/books"
  }

  volumes {
    host_path      = "/mnt/xwing/media/EBooks"
    container_path = "/files"
  }

  volumes {
    host_path      = "/mnt/xwing/media/EBooks/Comics"
    container_path = "/comics"
  }

  labels {
    "traefik.enable" = "true"

    "traefik.admin.port"          = 2203
    "traefik.admin.frontend.rule" = "Host:library.${var.domain}"

    # I do not trust the Ubooquity authentication
    # it does some shady JS encryption
    "traefik.admin.frontend.auth.basic" = "${var.basic_auth}"

    "traefik.read.port"          = 2202
    "traefik.read.frontend.rule" = "Host:read.${var.domain},comics.${var.domain},books.${var.domain}"

    "traefik.read.frontend.headers.SSLTemporaryRedirect"  = "true"
    "traefik.read.frontend.headers.STSSeconds"            = "2592000"
    "traefik.read.frontend.headers.STSIncludeSubdomains"  = "false"
    "traefik.read.frontend.headers.contentTypeNosniff"    = "true"
    "traefik.read.frontend.headers.browserXSSFilter"      = "true"
    "traefik.read.frontend.headers.customResponseHeaders" = "${var.xpoweredby}"
    "traefik.frontend.headers.customFrameOptionsValue"    = "${var.xfo_allow}"
  }

  upload {
    content = "${file("${path.module}/conf/ubooquity.json")}"
    file    = "/config/preferences.json"
  }

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "MAXMEM=800",
  ]
}

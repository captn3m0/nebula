data "docker_registry_image" "radicale" {
  name = "tomsquest/docker-radicale:latest"
}

resource "docker_image" "radicale" {
  name          = "${data.docker_registry_image.radicale.name}"
  pull_triggers = ["${data.docker_registry_image.radicale.sha256_digest}"]
}

resource docker_container "radicale" {
  name  = "radicale"
  image = "${docker_image.radicale.latest}"

  labels {
    "traefik.port"                                     = 5232
    "traefik.enable"                                   = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect"    = "true"
    "traefik.frontend.headers.STSSeconds"              = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains"    = "false"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.browserXSSFilter"        = "true"
    "traefik.frontend.passHostHeader"                  = "true"
    "traefik.frontend.rule"                            = "Host:${var.domain}"
  }

  volumes {
    host_path      = "/mnt/xwing/data/radicale"
    container_path = "/data"
  }

  volumes {
    host_path      = "/mnt/xwing/config/radicale"
    container_path = "/config"
  }

  upload {
    content = "${file("${path.module}/config")}"
    file    = "/config/config"
  }

  # env = [
  #   "PGID=1003",
  #   "PUID=1000",
  #   "TZ=Asia/Kolkata",
  # ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

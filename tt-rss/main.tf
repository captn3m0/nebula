data "docker_registry_image" "tt-rss" {
  name = "linuxserver/tt-rss:latest"
}

resource "docker_image" "tt-rss" {
  name          = "${data.docker_registry_image.tt-rss.name}"
  pull_triggers = ["${data.docker_registry_image.tt-rss.sha256_digest}"]
}

resource docker_container "tt-rss" {
  name  = "tt-rss"
  image = "${docker_image.tt-rss.latest}"

  labels {
    "traefik.port"                                  = 80
    "traefik.enable"                                = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"
    "traefik.frontend.headers.contentTypeNosniff"   = "true"
    "traefik.frontend.headers.browserXSSFilter"     = "true"
    "traefik.frontend.passHostHeader"               = "true"
    "traefik.frontend.rule"                         = "Host:${var.domain}"
  }

  volumes {
    host_path      = "/mnt/xwing/config/tt-rss"
    container_path = "/config"
  }

  links = ["mariadb"]

  env = [
    "TZ=Asia/Kolkata",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

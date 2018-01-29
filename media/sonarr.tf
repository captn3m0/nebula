data "docker_registry_image" "sonarr" {
  name = "linuxserver/sonarr:latest"
}

resource "docker_image" "sonarr" {
  name          = "${data.docker_registry_image.sonarr.name}"
  pull_triggers = ["${data.docker_registry_image.sonarr.sha256_digest}"]
}

resource docker_container "sonarr" {
  name  = "sonarr"
  image = "${docker_image.sonarr.latest}"

  labels {
    "traefik.port"                                  = 8989
    "traefik.enable"                                = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"
    "traefik.frontend.headers.contentTypeNosniff"   = "true"
    "traefik.frontend.headers.browserXSSFilter"     = "true"
    "traefik.frontend.passHostHeader"               = "true"
    "traefik.frontend.rule"                         = "Host:luke.${var.domain}"
  }

  memory                = 512
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/sonarr"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/TV"
    container_path = "/tv"
  }

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

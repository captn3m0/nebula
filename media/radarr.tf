data "docker_registry_image" "radarr" {
  name = "linuxserver/radarr:latest"
}

resource "docker_image" "radarr" {
  name          = "${data.docker_registry_image.radarr.name}"
  pull_triggers = ["${data.docker_registry_image.radarr.sha256_digest}"]
}

resource docker_container "radarr" {
  name  = "radarr"
  image = "${docker_image.radarr.latest}"

  labels {
    "traefik.port"                                  = 7878
    "traefik.enable"                                = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"
    "traefik.frontend.headers.contentTypeNosniff"   = "true"
    "traefik.frontend.headers.browserXSSFilter"     = "true"
    "traefik.frontend.passHostHeader"               = "true"

    # TODO: wildcard certs needed!
    "traefik.frontend.rule" = "Host:git.${var.domain}"
  }

  memory                = 512
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/radarr"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Movies"
    container_path = "/movies"
  }

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  links = ["emby", "transmission"]
}

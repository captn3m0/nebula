resource "docker_container" "emby" {
  name  = "emby"
  image = docker_image.emby.latest

  volumes {
    host_path      = "/mnt/xwing/config/emby"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media"
    container_path = "/media"
  }

  labels = merge(
    var.traefik-labels,
    {
      "traefik.frontend.rule"           = "Host:emby.in.${var.domain},emby.${var.domain}"
      "traefik.frontend.passHostHeader" = "true"
      "traefik.port"                    = 8096
    },
  )

  networks = [docker_network.media.id, var.traefik-network-id]

  memory                = 2048
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  # Running as lounge:tatooine
  env = [
    "APP_USER=lounge",
    "APP_UID=1004",
    "APP_GID=1003",
    "APP_CONFIG=/mnt/xwing/config",
    "TZ=Asia/Kolkata",
  ]
}

resource "docker_image" "emby" {
  name          = data.docker_registry_image.emby.name
  pull_triggers = [data.docker_registry_image.emby.sha256_digest]
}

data "docker_registry_image" "emby" {
  name = "emby/embyserver:latest"
}


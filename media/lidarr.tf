data "docker_registry_image" "lidarr" {
  name = "linuxserver/lidarr:latest"
}

resource "docker_image" "lidarr" {
  name          = data.docker_registry_image.lidarr.name
  pull_triggers = [data.docker_registry_image.lidarr.sha256_digest]
}

locals {
  lidarr_labels = merge(var.traefik-labels, {
    "traefik.port"          = 8686
    "traefik.frontend.rule" = "Host:lidarr.${var.domain}"
  })
}

resource "docker_container" "lidarr" {
  name  = "lidarr"
  image = docker_image.lidarr.latest

  dynamic "labels" {
    for_each = local.lidarr_labels
    content {
      label = labels.key
      value = labels.value
    }
  }


  memory                = 512
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/lidarr"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Music"
    container_path = "/music"
  }

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  networks = [docker_network.media.id, var.traefik-network-id]
}


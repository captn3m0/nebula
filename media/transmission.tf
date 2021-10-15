locals {
  transmission_labels = merge(var.traefik-labels, {
    "traefik.frontend.auth.basic" = var.basic_auth
    "traefik.port"                = 9091
  })
}

resource "docker_container" "transmission" {
  name  = "transmission"
  image = docker_image.transmission.latest

  dynamic "labels" {
    for_each = local.transmission_labels
    content {
      label = labels.key
      value = labels.value
    }
  }

  ports {
    internal = 51413
    external = 51413
    ip       = var.ips["eth0"]
    protocol = "udp"
  }

  volumes {
    host_path      = "/mnt/xwing/config/transmission"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Music/Audiobooks"
    container_path = "/audiobooks"
  }

  volumes {
    host_path      = "/mnt/xwing/data/watch/transmission"
    container_path = "/watch"
  }

  upload {
    content = file("${path.module}/conf/transmission.json")
    file    = "/config/settings.json"
  }

  env = [
    "PGID=1003",
    "PUID=1000",
    "TZ=Asia/Kolkata",
  ]

  networks = [docker_network.media.id, var.traefik-network-id]

  memory                = 1024
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

resource "docker_image" "transmission" {
  name          = data.docker_registry_image.transmission.name
  pull_triggers = [data.docker_registry_image.transmission.sha256_digest]
}

data "docker_registry_image" "transmission" {
  name = "linuxserver/transmission:latest"
}


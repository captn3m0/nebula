
locals {
  emby_labels = merge(var.traefik-labels, {
    "traefik.frontend.rule"           = "Host:emby.in.${var.domain},emby.${var.domain}"
    "traefik.frontend.passHostHeader" = "true"
    "traefik.port"                    = 8096
  })
}

resource "docker_container" "emby" {
  name  = "emby"
  image = docker_image.emby.image_id

  # SSD holds both the cache and data
  volumes {
    host_path      = "/mnt/zwing/config/emby"
    container_path = "/config"
  }

  # We keep the cache separate
  # So the config directory isn't bloated
  volumes {
    host_path      = "/mnt/zwing/cache/emby"
    container_path = "/config/cache"
  }

  # We want backups on the HDD
  volumes {
    host_path = "/mnt/xwing/backups/config/emby"
    container_path = "/backups"
  }

  # And mount the media as well
  volumes {
    host_path      = "/mnt/xwing/media"
    container_path = "/media"
  }

  dynamic "labels" {
    for_each = local.emby_labels
    content {
      label = labels.key
      value = labels.value
    }
  }

  networks = [docker_network.media.id, var.traefik-network-id]

  memory                = 2048
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  # This breaks every time we upgrade the kernel
  # or the nvidia driver, and needs a reboot.
  # gpus = "all"

  # Running as lounge:tatooine
  env = [
    "UID=1004",
    "GID=1003",
    "GIDLIST=1003"
  ]
}

resource "docker_image" "emby" {
  name          = data.docker_registry_image.emby.name
  pull_triggers = [data.docker_registry_image.emby.sha256_digest]
}

data "docker_registry_image" "emby" {
  name = "emby/embyserver:latest"
}


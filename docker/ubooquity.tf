locals {
  l = merge(local.traefik_common_labels, {
    "traefik.port"          = 3000
    "traefik.frontend.rule" = "Host:${var.domain}"
  })
}

resource "docker_container" "ubooquity" {
  name  = "ubooquity"
  image = docker_image.ubooquity.latest

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
    label = "traefik.enable"
    value = "true"
  }
  labels {
    label = "traefik.admin.port"
    value = 2203
  }
  labels {
    label = "traefik.admin.frontend.rule"
    value = "Host:library.${var.domain}"
  }
  labels {
    label = "traefik.admin.frontend.auth.basic"
    value = var.basic_auth
  }
  labels {
    label = "traefik.read.port"
    value = 2202
  }
  labels {
    label = "traefik.read.frontend.rule"
    value = "Host:read.${var.domain},comics.${var.domain},books.${var.domain}"
  }
  labels {
    label = "traefik.docker.network"
    value = "traefik"
  }

  upload {
    content = file("${path.module}/conf/ubooquity.json")
    file    = "/config/preferences.json"
  }

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "MAXMEM=800",
  ]
}


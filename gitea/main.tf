locals {
  l = merge(var.traefik-labels, {
    "traefik.port"          = 3000
    "traefik.frontend.rule" = "Host:${var.domain}"
  })
}

resource "docker_container" "gitea" {
  name  = "gitea"
  image = docker_image.gitea.image_id

  dynamic "labels" {
    for_each = local.l
    content {
      label = labels.key
      value = labels.value
    }
  }

  volumes {
    volume_name    = docker_volume.gitea_volume.name
    container_path = "/data"
    host_path      = docker_volume.gitea_volume.mountpoint
  }

  # For the following uploads, note that
  # /data/gitea is GITEA_CUSTOM_PATH

  # Logos

  # https://docs.gitea.com/next/administration/customizing-gitea#changing-the-logo
  # PNG images
  upload {
    content_base64 = filebase64("${path.module}/conf/public/img/gitea-lg.png")
    file           = "/data/gitea/public/assets/img/logo.png"
  }
  upload {
    content_base64 = filebase64("${path.module}/conf/public/img/gitea-lg.png")
    file           = "/data/gitea/public/assets/img/apple-touch-icon.png"
  }
  upload {
    content_base64 = filebase64("${path.module}/conf/public/img/gitea-sm.png")
    file           = "/data/gitea/public/assets/img/favicon.png"
  }

  # SVG images
  upload {
    content_base64 = filebase64("${path.module}/conf/public/img/favicon.svg")
    file           = "/data/gitea/public/assets/img/logo.svg"
  }
  upload {
    content_base64 = filebase64("${path.module}/conf/public/img/favicon.svg")
    file           = "/data/gitea/public/assets/img/favicon.svg"
  }

  # Some files at top-level
  upload {
    content = file("${path.module}/conf/public/humans.txt")
    file    = "/data/gitea/public/humans.txt"
  }
  upload {
    content = file("${path.module}/conf/public/robots.txt")
    file    = "/data/gitea/public/robots.txt"
  }

  # Extra Links in header
  upload {
    content = file("${path.module}/conf/extra_links.tmpl")
    file    = "/data/gitea/templates/custom/extra_links.tmpl"
  }

  # This is the main configuration file
  upload {
    content = data.template_file.gitea-config-file.rendered
    file    = "/data/gitea/conf/app.ini"
  }

  memory                = 800
  restart               = "always"
  destroy_grace_seconds = 10
  must_run              = true
  networks              = ["gitea", "traefik"]
}

resource "docker_image" "gitea" {
  name          = data.docker_registry_image.gitea.name
  pull_triggers = [data.docker_registry_image.gitea.sha256_digest]
}


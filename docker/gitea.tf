resource docker_container "gitea" {
  name  = "gitea"
  image = "${docker_image.gitea.latest}"

  labels {
    "traefik.port"                                     = 3000
    "traefik.enable"                                   = "true"
    "traefik.frontend.rule"                            = "Host:git.captnemo.in"
    "traefik.frontend.headers.STSSeconds"              = "2592000"
    "traefik.frontend.headers.browserXSSFilter"        = "true"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect"    = "true"
    "traefik.frontend.headers.STSIncludeSubdomains"    = "false"
    "traefik.frontend.headers.customResponseHeaders"   = "${var.xpoweredby}"
    "traefik.frontend.headers.customFrameOptionsValue" = "${var.xfo_allow}"
  }

  ports {
    internal = 22
    external = 2222
    ip       = "${var.ips["eth0"]}"
  }

  ports {
    internal = 22
    external = 2222
    ip       = "${var.ips["tun0"]}"
  }

  volumes {
    volume_name    = "${docker_volume.gitea_volume.name}"
    container_path = "/data"
    host_path      = "${docker_volume.gitea_volume.mountpoint}"
  }

  upload {
    content = "${file("${path.module}/conf/gitea/public/img/gitea-lg.png")}"
    file    = "/data/gitea/public/img/gitea-lg.png"
  }

  upload {
    content = "${file("${path.module}/conf/gitea/public/img/gitea-sm.png")}"
    file    = "/data/gitea/public/img/gitea-sm.png"
  }

  upload {
    content = "${file("${path.module}/conf/gitea/public/img/gitea-sm.png")}"
    file    = "/data/gitea/public/img/favicon.png"
  }

  upload {
    content = "${file("${path.module}/conf/humans.txt")}"
    file    = "/data/gitea/public/humans.txt"
  }

  # TODO: Add svg

  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

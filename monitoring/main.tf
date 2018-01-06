resource docker_container "grafana" {
  name  = "grafana"
  image = "${docker_image.grafana.latest}"

  labels {
    # "traefik.frontend.auth.basic"                      = "${var.basic_auth}"
    "traefik.port"                                     = 3000
    "traefik.enable"                                   = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect"    = "true"
    "traefik.frontend.headers.STSSeconds"              = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains"    = "false"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.browserXSSFilter"        = "true"
    # "traefik.frontend.headers.customResponseHeaders"   = "${var.xpoweredby}"
    # "traefik.frontend.headers.customFrameOptionsValue" = "${var.xfo_allow}"
  }

  volumes {
    host_path      = "/mnt/xwing/data/grafana"
    container_path = "/var/lib/grafana"
  }

  links = ["prometheus"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

resource docker_container "prometheus" {
  name  = "prometheus"
  image = "${docker_image.prometheus.latest}"

  command = ["--config.file=/etc/prometheus/prometheus.yml"]

  volumes {
    host_path      = "/mnt/xwing/data/prometheus"
    container_path = "/prometheus"
  }

  upload {
    content = "${file("${path.module}/config/prometheus.yml")}"
    file    = "/etc/prometheus/prometheus.yml"
  }

  links = ["nodeexporter"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

resource docker_container "nodeexporter" {
  name  = "nodeexporter"
  image = "${docker_image.nodeexporter.latest}"

  volumes {
    host_path      = "/proc"
    container_path = "/host/proc"
  }

  volumes {
    host_path      = "/sys"
    container_path = "/host/sys"
  }

  volumes {
    host_path      = "/"
    container_path = "/rootfs"
    read_only      = true
  }

  command = [
    "--path.procfs=/host/proc",
    "--path.sysfs=/host/sys",
    "--collector.filesystem.ignored-mount-points=\"^/(sys|proc|dev|host|etc)($$|/)\""
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}


resource docker_container "grafana" {
  name  = "grafana"
  image = "${docker_image.grafana.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 3000,
      "traefik.frontend.rule","Host:grafana.${var.domain}"
  ))}"

  volumes {
    host_path      = "/mnt/xwing/data/grafana"
    container_path = "/var/lib/grafana"
  }

  links = ["${docker_container.prometheus.name}"]

  env = [
    "GF_SECURITY_ADMIN_PASSWORD=${var.gf-security-admin-password}",
    "GF_SERVER_ROOT_URL=https://grafana.${var.domain}",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

resource docker_container "prometheus" {
  name  = "prometheus"
  image = "${docker_image.prometheus.latest}"

  # prometheus:prometheus
  user = "985:983"

  command = ["--config.file=/etc/prometheus/prometheus.yml"]

  volumes {
    host_path      = "/mnt/xwing/data/prometheus"
    container_path = "/prometheus"
  }

  upload {
    content = "${file("${path.module}/config/prometheus.yml")}"
    file    = "/etc/prometheus/prometheus.yml"
  }

  links = ["${docker_container.nodeexporter.name}", "${docker_container.cadvisor.name}"]

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
    "--collector.filesystem.ignored-mount-points=\"^/(sys|proc|dev|host|etc)($$|/)\"",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = "${docker_image.prometheus.latest}"

  # prometheus:prometheus
  user = "985:983"

  ports {
    internal = 9090
    external = 9090
    ip       = "${var.ips["eth0"]}"
  }

  ports {
    internal = 9090
    external = 9090
    ip       = "${var.ips["tun0"]}"
  }

  command = ["--config.file=/etc/prometheus/prometheus.yml"]

  volumes {
    host_path      = "/mnt/xwing/data/prometheus"
    container_path = "/prometheus"
  }

  upload {
    content = "${file("${path.module}/config/prometheus.yml")}"
    file    = "/etc/prometheus/prometheus.yml"
  }

  networks = [
    "${docker_network.monitoring.id}",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

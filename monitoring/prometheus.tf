resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.prometheus.image_id

  # prometheus:prometheus
  user = "985:983"

  ports {
    internal = 9090
    external = 8811
    ip       = var.ips["eth0"]
  }

  ports {
    internal = 9090
    external = 8811
    ip       = var.ips["ts"]
  }

  command = ["--config.file=/etc/prometheus/prometheus.yml"]

  volumes {
    host_path      = "/mnt/xwing/data/prometheus"
    container_path = "/prometheus"
  }

  upload {
    content = file("${path.module}/config/prometheus.yml")
    file    = "/etc/prometheus/prometheus.yml"
  }

  networks = ["monitoring", "bridge"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

data "docker_network" "bridge" {
  name = "bridge"
}


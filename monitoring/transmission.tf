# Transmission Exporter for prometheus
# https://github.com/metalmatze/transmission-exporter

resource docker_container "transmission-exporter" {
  name  = "transmission-exporter"
  image = "${docker_image.transmission-exporter.latest}"

  links = ["${var.transmission}"]

  ports {
    internal = 19091
    external = 19091
    ip       = "${var.ips["eth0"]}"
  }

  env = [
    "TRANSMISSION_ADDR=http://${var.transmission}:9091",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

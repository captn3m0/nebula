# Transmission Exporter for prometheus
# https://github.com/metalmatze/transmission-exporter
resource docker_container "transmission-exporter" {
  name  = "transmission-exporter"
  image = "${docker_image.transmission-exporter.latest}"

  links = ["${var.transmission}"]

  env = [
    "TRANSMISSION_ADDR=http://transmission:9091",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

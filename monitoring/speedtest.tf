# Transmission Exporter for speedtest results
# https://hub.docker.com/r/stefanwalther/speedtest-exporter/
resource docker_container "speedtest" {
  name  = "speedtest"
  image = "${docker_image.speedtest.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

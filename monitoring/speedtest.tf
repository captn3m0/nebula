# Transmission Exporter for speedtest results
# https://hub.docker.com/r/stefanwalther/speedtest-exporter/
# Built against Alpine: https://github.com/stefanwalther/speedtest-exporter/pull/7
resource "docker_container" "speedtest" {
  name  = "speedtest"
  image = "${docker_image.speedtest.latest}"

  networks = [
    "${data.docker_network.bridge.id}",
    "${docker_network.monitoring.id}",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

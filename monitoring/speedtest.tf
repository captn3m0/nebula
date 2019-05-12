# Transmission Exporter for speedtest results
# https://hub.docker.com/r/stefanwalther/speedtest-exporter/
# Built against Alpine: https://github.com/stefanwalther/speedtest-exporter/pull/7

module "speedtest" {
  name   = "speedtest"
  image  = "captn3m0/speedtest-exporter:alpine"
  source = "../modules/container"

  networks_advanced = [
    {
      name    = "monitoring"
      aliases = ["speedtest", "speedtest.docker"]
    },
    {
      name = "bridge"
    },
  ]

  resource {
    memory      = 256
    memory_swap = 256
  }

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

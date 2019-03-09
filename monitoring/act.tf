data "docker_registry_image" "act-exporter" {
  name = "captn3m0/prometheus-act-exporter:latest"
}

resource "docker_container" "act-exporter" {
  name  = "act-exporter"
  image = "${docker_image.act-exporter.latest}"

  entrypoint = ["/usr/local/bin/node", "server.js"]

  networks = [
    "${data.docker_network.bridge.id}",
    "${docker_network.monitoring.id}",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

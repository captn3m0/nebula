data "docker_registry_image" "act-exporter" {
  name = "captn3m0/prometheus-act-exporter:latest"
}

resource "docker_container" "act-exporter" {
  name  = "act-exporter"
  image = "${docker_image.act-exporter.latest}"

  entrypoint = ["/usr/local/bin/node", "server.js"]

  networks_advanced {
    name    = "monitoring"
    aliases = ["act-exporter", "act-exporter.docker"]
  }

  // So it can talk to ACT
  networks_advanced {
    name = "bridge"
  }

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

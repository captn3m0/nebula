data "docker_registry_image" "act-exporter" {
  name = "captn3m0/prometheus-act-exporter:latest"
}

resource "docker_container" "act-exporter" {
  name  = "act-exporter"
  image = docker_image.act-exporter.image_id

  entrypoint = ["/usr/local/bin/node", "server.js"]

  networks_advanced {
    name    = "monitoring"
    aliases = ["act-exporter", "act-exporter.docker"]
  }

  // So it can talk to ACT
  networks = ["bridge"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}


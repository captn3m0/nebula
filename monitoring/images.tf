resource "docker_image" "prometheus" {
  name          = data.docker_registry_image.prometheus.name
  pull_triggers = [data.docker_registry_image.prometheus.sha256_digest]
}

resource "docker_image" "act-exporter" {
  name          = data.docker_registry_image.act-exporter.name
  pull_triggers = [data.docker_registry_image.act-exporter.sha256_digest]
  keep_locally  = true
}


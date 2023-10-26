resource "docker_image" "prometheus" {
  name          = data.docker_registry_image.prometheus.name
  pull_triggers = [data.docker_registry_image.prometheus.sha256_digest]
}

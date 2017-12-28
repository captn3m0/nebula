resource "docker_image" "grafana" {
  name          = "${data.docker_registry_image.grafana.name}"
  pull_triggers = ["${data.docker_registry_image.grafana.sha256_digest}"]
}

resource "docker_image" "prometheus" {
  name          = "${data.docker_registry_image.prometheus.name}"
  pull_triggers = ["${data.docker_registry_image.prometheus.sha256_digest}"]
}

resource "docker_image" "alertmanager" {
  name          = "${data.docker_registry_image.alertmanager.name}"
  pull_triggers = ["${data.docker_registry_image.alertmanager.sha256_digest}"]
}
resource "docker_image" "nodeexporter" {
  name          = "${data.docker_registry_image.nodeexporter.name}"
  pull_triggers = ["${data.docker_registry_image.nodeexporter.sha256_digest}"]
}

resource "docker_image" "grafana" {
  name          = "${data.docker_registry_image.grafana.name}"
  pull_triggers = ["${data.docker_registry_image.grafana.sha256_digest}"]
}

resource "docker_image" "prometheus" {
  name          = "${data.docker_registry_image.prometheus.name}"
  pull_triggers = ["${data.docker_registry_image.prometheus.sha256_digest}"]
}

resource "docker_image" "nodeexporter" {
  name          = "${data.docker_registry_image.nodeexporter.name}"
  pull_triggers = ["${data.docker_registry_image.nodeexporter.sha256_digest}"]
}

resource "docker_image" "cadvisor" {
  name          = "${data.docker_registry_image.cadvisor.name}"
  pull_triggers = ["${data.docker_registry_image.cadvisor.sha256_digest}"]
}

resource "docker_image" "speedtest" {
  name          = "${data.docker_registry_image.speedtest.name}"
  pull_triggers = ["${data.docker_registry_image.speedtest.sha256_digest}"]
}

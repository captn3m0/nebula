data "docker_registry_image" "grafana" {
  name = "grafana/grafana"
}

data "docker_registry_image" "prometheus" {
  name = "prom/prometheus"
}

data "docker_registry_image" "nodeexporter" {
  name = "prom/node-exporter"
}

data "docker_registry_image" "cadvisor" {
  name = "google/cadvisor:latest"
}

data "docker_registry_image" "speedtest" {
  name = "stefanwalther/speedtest-exporter:latest"
}

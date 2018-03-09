data "docker_registry_image" "grafana" {
  name = "grafana/grafana:5.0.1"
}

data "docker_registry_image" "prometheus" {
  name = "prom/prometheus:latest"
}

data "docker_registry_image" "nodeexporter" {
  name = "prom/node-exporter:latest"
}

data "docker_registry_image" "cadvisor" {
  name = "google/cadvisor:latest"
}

data "docker_registry_image" "speedtest" {
  name = "stefanwalther/speedtest-exporter:latest"
}

data "docker_registry_image" "grafana" {
  name = "grafana/grafana:latest"
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
  name = "captn3m0/speedtest-exporter:alpine"
}

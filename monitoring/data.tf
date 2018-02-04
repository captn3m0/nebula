data "docker_registry_image" "grafana" {
  name = "grafana/grafana"
}

data "docker_registry_image" "prometheus" {
  name = "prom/prometheus"
}

# data "docker_registry_image" "alertmanager" {
#   name = "prom/alertmanager"
# }

data "docker_registry_image" "nodeexporter" {
  name = "prom/node-exporter"
}

data "docker_registry_image" "transmission-exporter" {
  name = "metalmatze/transmission-exporter"
}

data "docker_registry_image" "cadvisor" {
  name = "google/cadvisor:latest"
}

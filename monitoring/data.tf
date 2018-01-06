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
  name = "captn3m0/transmission-exporter"
}

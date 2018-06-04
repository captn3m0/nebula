resource "docker_container" "grafana" {
  name  = "grafana"
  image = "${docker_image.grafana.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 3000,
      "traefik.frontend.rule","Host:grafana.${var.domain}"
  ))}"

  volumes {
    host_path      = "/mnt/xwing/data/grafana"
    container_path = "/var/lib/grafana"
  }

  links    = ["${docker_container.prometheus.name}"]
  networks = ["${var.traefik-network-id}"]

  env = [
    # Keep this disabled unless bringing up a new grafana instance
    # "GF_SECURITY_ADMIN_PASSWORD=${var.gf-security-admin-password}",
    "GF_SERVER_ROOT_URL=https://grafana.${var.domain}",

    "GF_AUTH_ANONYMOUS_ENABLED=true",
    "GF_AUTH_ANONYMOUS_ORG_NAME=Tatooine",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

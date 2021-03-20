# resource "docker_container" "grafana" {
module "grafana" {
  name   = "grafana"
  source = "../modules/container"
  image  = "grafana/grafana:latest"

  // grafana:grafana
  user = "984:982"

  web = {
    port   = 3000
    host   = "grafana.${var.domain}"
    expose = true
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/data/grafana"
      container_path = "/var/lib/grafana"
    },
  ]

  networks_advanced = [
    {
      name = "traefik"
    },
    {
      name = "monitoring"
    },
  ]

  env = [
    "GF_SERVER_ROOT_URL=https://grafana.${var.domain}",
    "GF_AUTH_ANONYMOUS_ENABLED=true",
    "GF_AUTH_ANONYMOUS_ORG_NAME=Tatooine",
    "GF_SECURITY_ADMIN_PASSWORD=${var.gf-security-admin-password}",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}


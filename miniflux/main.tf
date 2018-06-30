data "docker_registry_image" "miniflux" {
  name = "miniflux/miniflux:2.0.8"
}

resource "docker_image" "miniflux" {
  name          = "${data.docker_registry_image.miniflux.name}"
  pull_triggers = ["${data.docker_registry_image.miniflux.sha256_digest}"]
}

resource "docker_container" "miniflux" {
  name  = "miniflux"
  image = "${docker_image.miniflux.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 8080,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  networks = ["${var.traefik-network-id}", "${var.postgres-network-id}"]

  env = [
    "DATABASE_URL=postgres://miniflux:${var.db-password}@postgres/miniflux?sslmode=disable",
    "RUN_MIGRATIONS=1",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

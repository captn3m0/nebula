module "miniflux-container" {
  name   = "miniflux"
  source = "modules/container"
  image  = "miniflux/miniflux:2.0.14"

  web {
    expose = true
    port   = 8080
    host   = "rss.captnemo.in"
  }

  networks = "${list(
    data.docker_network.bridge.id,
    module.docker.traefik-network-id,
    module.db.postgres-network-id
  )}"

  env = [
    "DATABASE_URL=postgres://miniflux:${var.miniflux-db-password}@postgres/miniflux?sslmode=disable",
    "RUN_MIGRATIONS=1",
  ]
}

module "miniflux-db" {
  source   = "modules/postgres"
  name     = "miniflux"
  password = "${var.miniflux-db-password}"
}

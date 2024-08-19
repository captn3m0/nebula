data "github_release" "miniflux" {
    repository  = "v2"
    owner       = "miniflux"
    retrieve_by = "latest"
}

module "miniflux-container" {
  name   = "miniflux"
  source = "./modules/container"
  image  = "miniflux/miniflux:${trimprefix(data.github_release.miniflux.release_tag, "v")}"

  web = {
    expose = true
    port   = 8080
    host   = "rss.captnemo.in"
  }

  networks = ["bridge", "postgres"]

  env = [
    "DATABASE_URL=postgres://miniflux:${data.pass_password.miniflux-db-password.password}@postgres/miniflux?sslmode=disable",
    "RUN_MIGRATIONS=1",
  ]

  resource = {
    memory      = 512
    memory_swap = 1024
  }
}

module "miniflux-db" {
  source   = "./modules/postgres"
  name     = "miniflux"
  password = data.pass_password.miniflux-db-password.password
}


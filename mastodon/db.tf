module "mastodon-redis" {
  name   = "mastodon-redis"
  source = "../modules/container"
  image  = "redis:alpine"
  networks   = ["mastodon"]
  keep_image = true

  resource = {
    memory      = 256
    memory_swap = 256
  }
}

module "mastodon-db" {
  source   = "../modules/postgres"
  name     = "mastodon"
  password = var.db-password
}

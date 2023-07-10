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

  # In case the cache dies,
  # tootctl feeds build
  # regenerates the feeds, run it from
  # inside a mastodon container
  volumes = [
    {
      host_path      = "/mnt/zwing/cache/mastodon-redis"
      container_path = "/data"
    }
  ]
}

module "mastodon-db" {
  source   = "../modules/postgres"
  name     = "mastodon"
  password = var.db-password
}

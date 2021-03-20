module "redis" {
  name   = "opml-redis"
  source = "../modules/container"
  image  = "redis:alpine"
  # TODO FIXME
  # networks   = [docker_network.opml.id]
  keep_image = true

  # ThisSucks
  web = {
    expose = "false"
  }

  resource = {
    memory      = 256
    memory_swap = 256
  }
}


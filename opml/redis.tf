module "redis" {
  name     = "opml-redis"
  source   = "../modules/container"
  image    = "redis:alpine"
  networks = ["${docker_network.opml.id}"]

  # ThisSucks
  web {
    expose = "false"
    host   = ""
  }

  resource {
    memory = 256
  }
}

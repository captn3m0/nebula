module "opml" {
  name     = "opml"
  source   = "../modules/container"
  image    = "captn3m0/opml-gen:latest"
  networks = ["${docker_network.opml.id}", "${var.traefik-network-id}"]

  web {
    expose = true
    host   = "opml.${var.domain}"
  }

  env = [
    "GITHUB_CLIENT_ID=${var.client-id}",
    "GITHUB_CLIENT_SECRET=${var.client-secret}",
    "REDIS_URL=redis://opml-redis:6379/1",
  ]

  resource {
    memory = 256
  }
}

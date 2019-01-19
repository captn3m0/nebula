module "container" {
  source = "../container"
  name   = "outline"

  # Switch to Alpine instead of Default Node for a smaller build
  image = "captn3m0/outline:alpine"

  web {
    expose = "true"
    host   = "${var.hostname}"
    port   = 3000
  }

  resource {
    memory      = 1024
    memory_swap = 2048
  }

  networks = [
    "${docker_network.outline.id}",
    "${data.docker_network.postgres.id}",
  ]

  env                   = "${local.environment}"
  destroy_grace_seconds = "22"
}

module "rss-bridge" {
  name   = "rss-bridge"
  source = "./modules/container"

  image = "ghcr.io/rss-bridge/rss-bridge:latest"

  resource = {
    memory      = 256
    memory_swap = 256
  }

  web = {
    expose = "true"
    host   = "rss-bridge.${var.root-domain}"
  }

  networks = ["bridge"]

  volumes = [
    {
      container_path = "/app/whitelist.txt"
      host_path      = "/mnt/xwing/config/rss-bridge/whitelist.txt"
    },
  ]
}


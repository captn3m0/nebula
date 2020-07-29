module "rss-bridge" {
  name   = "rss-bridge"
  source = "modules/container"

  image = "captn3m0/rss-bridge:develop"

  resource {
    memory      = 256
    memory_swap = 256
  }

  web {
    expose = "true"
    host   = "rss-bridge.${var.root-domain}"
  }

  networks_advanced = [
    {
      name = "external"
    },
    {
      name = "traefik"
    },
  ]

  volumes = [{
    container_path = "/app/whitelist.txt"
    host_path      = "/mnt/xwing/config/rss-bridge/whitelist.txt"
  }]
}

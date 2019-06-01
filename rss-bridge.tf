module "rss-bridge" {
  name   = "rss-bridge"
  source = "modules/container"

  image = "rssbridge/rss-bridge:latest"

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

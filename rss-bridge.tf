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
      name = "bridge"
    },
    {
      name = "traefik"
    },
  ]

  volumes = [{
    container_path = "/app/public/whitelist.txt"
    host_path      = "/mnt/xwing/config/rss-bridge/whitelist.txt"
  }]
}

module "rss-bridge" {
  name   = "rss-bridge"
  source = "modules/container"

  image = "rss-bridge/rss-bridge:latest"

  web {
    expose = "true"
    host   = "rss-bridge.${var.root-domain}"
  }

  networks = ["${data.docker_network.bridge.id}"]

  volumes = [{
    container_path = "/app/public/whitelist.txt"
    host_path      = "/mnt/xwing/config/rss-bridge/whitelist.txt"
  }]
}

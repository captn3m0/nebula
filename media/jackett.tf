module "jackett" {
  name   = "jackett"
  source = "../modules/container"
  image  = "linuxserver/jackett:latest"

  web {
    expose = true
    port   = 9117
    host   = "jackett.${var.domain}"
  }

  networks = ["${docker_network.media.id}", "${var.traefik-network-id}"]

  volumes = [{
    host_path      = "/mnt/xwing/config/jackett"
    container_path = "/config"
  }]

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

module "prowlarr" {
  name   = "prowlarr"
  source = "../modules/container"
  image  = "linuxserver/prowlarr:nightly"

  web = {
    expose = true
    port   = 9696
    host   = "prowlarr.${var.domain}"
    auth   = true
  }

  resource = {
    memory      = 1024
    memory_swap = 1024
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/config/prowlarr"
      container_path = "/config"
    }
  ]

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  networks = [docker_network.media.id, data.docker_network.bridge.id]
}


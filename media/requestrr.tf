module "requestrr" {
  name   = "requestrr"
  source = "../modules/container"
  image  = "thomst08/requestrr:latest"

  web = {
    expose = true
    port   = 4545
    host   = "requestrr.${var.domain}"
  }

  resource = {
    memory      = 512
    memory_swap = 512
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/config/requestrr"
      container_path = "/root/config"
    },
  ]

  networks = [docker_network.media.id, data.docker_network.bridge.id]
}


module "requestrr" {
  name   = "requestrr"
  source = "../modules/container"
  image  = "darkalfx/requestrr:latest"

  web = {
    expose = true
    port   = 4545
    host   = "requestrr.${var.domain}"
  }

  resource = {
    memory      = 256
    memory_swap = 256
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/config/requestrr"
      container_path = "/root/config"
    },
  ]

  # TODO FIXME
  # networks = [docker_network.media.id, data.docker_network.bridge.id]
}


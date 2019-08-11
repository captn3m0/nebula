module "bazarr-container" {
  name   = "bazarr"
  source = "../modules/container"
  image  = "linuxserver/bazarr:latest"

  web {
    expose = true
    port   = 6767
    host   = "bazarr.${var.domain}"
  }

  resource {
    memory      = 512
    memory_swap = 1024
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/config/bazarr"
      container_path = "/config"
    },
    {
      host_path      = "/mnt/xwing/media/TV"
      container_path = "/tv"
    },
    {
      host_path      = "/mnt/xwing/media/Movies"
      container_path = "/movies"
    },
  ]

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  networks = "${list(docker_network.media.id, data.docker_network.bridge.id)}"
}

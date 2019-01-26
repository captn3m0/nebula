module "sonarr-container" {
  name   = "sonarr"
  source = "../modules/container"
  image  = "linuxserver/sonarr:latest"

  web {
    expose = true
    port   = 8989
    host   = "sonarr.${var.domain}"
  }

  resource {
    memory      = 512
    memory_swap = 1024
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/config/sonarr"
      container_path = "/config"
    },
    {
      host_path      = "/mnt/xwing/media/DL"
      container_path = "/downloads"
    },
    {
      host_path      = "/mnt/xwing/media/TV"
      container_path = "/tv"
    },
  ]

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  networks = "${list(docker_network.media.id)}"
}

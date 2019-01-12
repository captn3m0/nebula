module "radarr" {
  name   = "radarr"
  source = "../modules/container"
  image  = "linuxserver/radarr:latest"

  web {
    expose = true
    port   = 7878
    host   = "radarr.${var.domain}"
  }

  resource {
    memory      = 512
    memory_swap = 1024
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/config/radarr"
      container_path = "/config"
    },
    {
      host_path      = "/mnt/xwing/media/DL"
      container_path = "/downloads"
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
}

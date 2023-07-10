module "radarr" {
  name   = "radarr"
  source = "../modules/container"
  image  = "linuxserver/radarr:latest"

  networks = [docker_network.media.id, data.docker_network.bridge.id]

  web = {
    expose = true
    port   = 7878
    host   = "radarr.${var.domain}"
  }

  resource = {
    memory      = 512
    memory_swap = 1024
  }

  volumes = [
    {
      host_path      = "/mnt/zwing/config/radarr"
      container_path = "/config"
    },
    # Backups stay on spinning disks
    {
      host_path      = "/mnt/xwing/backups/config/sonarr"
      container_path = "/config/Backups"
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


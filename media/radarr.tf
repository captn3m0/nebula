module "radarr" {
  name   = "radarr"
  source = "../modules/container"
  image  = "linuxserver/radarr:latest"

  networks = "${list(docker_network.media.id, data.docker_network.bridge.id)}"

  // TODO: Create a new separate network for DNS
  // and use that instead
  dns = ["192.168.1.111"]

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

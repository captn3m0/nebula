module "jackett" {
  name   = "jackett"
  source = "../modules/container"
  image  = "linuxserver/jackett:latest"

  web {
    expose = true
    port   = 9117
    host   = "jackett.${var.domain}"
  }

  volumes = [{
    host_path      = "/mnt/xwing/config/jackett"
    container_path = "/config"
  }]

  resource {
    memory = "256"
  }

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

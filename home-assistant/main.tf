module "home-assistant" {
  name   = "home-assistant"
  source = "../modules/container"

  image = "ghcr.io/home-assistant/home-assistant:stable"

  resource = {
    memory      = 1024
    memory_swap = 1024
  }

  env = [
    "TZ=Asia/Kolkata",
  ]

  network_mode = "host"

  volumes = [
    {
      container_path = "/config"
      host_path      = "/mnt/zwing/config/home-assistant"
    },
  ]
}

module "elibsrv" {
  name   = "elibsrv"
  source = "./modules/container"
  image  = "captn3m0/elibsrv"

  resource {
    memory      = 512
    memory_swap = 512
  }

  web {
    expose = true
    host   = "ebooks.${var.root-domain}"
    auth   = true
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/media/EBooks"
      container_path = "/books"
      read_only      = true
    },
    {
      host_path      = "/mnt/xwing/config/elibsrv"
      container_path = "/config"
      read_only      = true
    },
    {
      host_path      = "/mnt/xwing/cache/elibsrv"
      container_path = "/cache"
    },
  ]

  env = [
    "elibsrv_thumbheight=320",
    "elibsrv_title=Scarif Media Archives",
  ]

  networks_advanced = [
    {
      name = "traefik"
    },
    {
      name = "bridge"
    },
  ]
}

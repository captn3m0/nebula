module "znc" {
  source = "./modules/container"
  image  = "znc:latest"
  name   = "znc"

  volumes = [
    {
      container_path = "/znc-data"
      host_path      = "/mnt/xwing/config/znc"
    },
  ]

  ports = [
    {
      internal = "6697"
      external = "6697"
      ip       = var.ips["tun0"]
    },
  ]
}


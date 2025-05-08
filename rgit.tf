module "rgit" {
  name   = "rgit"
  source = "./modules/container"
  image  = "ghcr.io/w4/rgit:main"

  web = {
    expose = true
    port   = 8000
    host   = "git.captnemo.in"
  }

  user = "1000:1000"

  networks = ["traefik"]
  command = [
    "[::]:8000",
    "/git",
    "-d",
    "/dev/shm/rgit-cache.db"
  ]

  env = [
    "REFRESH_INTERVAL=5m"
  ]

  volumes = [
    {
      host_path      = "/mnt/xwing/data/gickup"
      container_path = "/git",
      read_only = true
      type= "bind"
    }
  ]

  resource = {
    memory      = 512
    memory_swap = 512
  }
}

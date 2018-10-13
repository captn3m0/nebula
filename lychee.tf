module "lychee" {
  source = "modules/container"
  name   = "lychee"
  image  = "linuxserver/lychee:latest"

  volumes = [{
    host_path      = "/mnt/xwing/config/lychee"
    container_path = "/config"
  },
    {
      host_path      = "/mnt/xwing/data/lychee"
      container_path = "/pictures"
    },
  ]

  files = "/config/lychee/user.ini"

  contents = ["${file("${path.module}/docker/conf/lychee.php.ini")}"]

  web {
    expose = true
    host   = "pics.bb8.fun"
  }

  env = [
    "PUID=986",
    "PGID=984",
  ]
}

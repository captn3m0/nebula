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

  uploads = [{
    content = "${file("${path.module}/docker/conf/lychee.php.ini")}"
    file    = "/config/lychee/user.ini"
  }]

  web {
    expose = true
    host   = "pics.bb8.fun"
  }

  env = [
    "PUID=986",
    "PGID=984",
  ]
}

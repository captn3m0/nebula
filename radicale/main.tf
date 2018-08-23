module "container" {
  name   = "radicale"
  source = "../modules/container"
  image  = "tomsquest/docker-radicale:latest"

  web {
    expose = true
    port   = 5232
    host   = "${var.domain}"
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/data/radicale"
      container_path = "/data"
    },
    {
      host_path      = "/mnt/xwing/config/radicale"
      container_path = "/config"
    },
  ]

  uploads = [
    {
      content = "${file("${path.module}/config")}"
      file    = "/config/config"
    },
    {
      content = "${file("${path.module}/logging.conf")}"
      file    = "/config/logging"
    },
    {
      content = "${file("${path.module}/users")}"
      file    = "/config/users"
    },
  ]
}

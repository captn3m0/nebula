module "container" {
  name   = "radicale"
  source = "../modules/container"
  image  = "tomsquest/docker-radicale:amd64"

  resource = {
    memory      = 2000
    memory_swap = 2000
  }

  # TODO Drop Capabilities
  # https://github.com/tomsquest/docker-radicale#option-2-recommended-production-grade-instruction-secured-safe-rocket

  web = {
    expose = true
    port   = 5232
    host   = var.domain
  }

  # SSD
  volumes = [
    {
      host_path      = "/mnt/zwing/config/radicale"
      container_path = "/data"
    }
  ]

  uploads = [
    {
      content = file("${path.module}/config")
      file    = "/config/config"
    },
    {
      content = file("${path.module}/logging.conf")
      file    = "/config/logging"
    },
    {
      content = file("${path.module}/users")
      file    = "/config/users"
    },
  ]
}

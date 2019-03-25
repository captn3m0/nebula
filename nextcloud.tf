module "nextcloud-db" {
  source   = "modules/postgres"
  name     = "nextcloud"
  password = "${data.pass_password.nextcloud-db-password.password}"
}

module "nextcloud-container" {
  source = "modules/container"
  name   = "nextcloud"
  image  = "nextcloud:15-apache"

  volumes = [{
    container_path = "/var/www/html"
    host_path      = "/mnt/xwing/data/nextcloud"
  }]

  env = [
    "POSTGRES_DB=nextcloud",
    "POSTGRES_USER=nextcloud",
    "POSTGRES_PASSWORD=${data.pass_password.nextcloud-db-password.password}",
    "POSTGRES_HOST=postgres",
    "NEXTCLOUD_TRUSTED_DOMAINS=c.${var.root-domain},nextcloud.${var.root-domain}",
    "NEXTCLOUD_UPDATE=0",
    "REDIS_HOST=nextcloud-redis",
  ]

  resource {
    memory      = 1024
    memory_swap = 1024
  }

  web {
    expose = true
    port   = 80
    host   = "c.${var.root-domain}"
  }

  # module.docker.traefik-network-id,
  networks = "${list(
    data.docker_network.bridge.id,
    module.db.postgres-network-id
  )}"
}

module "nextcloud-redis" {
  name     = "nextcloud-redis"
  source   = "modules/container"
  image    = "redis:alpine"
  networks = ["${data.docker_network.bridge.id}"]

  # ThisSucks
  web {
    expose = "false"
  }

  resource {
    memory      = 256
    memory_swap = 256
  }
}

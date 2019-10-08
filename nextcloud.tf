module "nextcloud-db" {
  source   = "modules/postgres"
  name     = "nextcloud"
  password = "${data.pass_password.nextcloud-db-password.password}"
}

module "nextcloud-container" {
  source = "modules/container"
  name   = "nextcloud"
  image  = "linuxserver/nextcloud"

  volumes = [
    {
      container_path = "/data"
      host_path      = "/mnt/xwing/data/nextcloud/data"
    },
    {
      container_path = "/config"
      host_path      = "/mnt/xwing/config/nextcloud"
    },
  ]

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
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
    port   = 443
    host   = "c.${var.root-domain}"
  }

  networks_advanced = [
    {
      name = "traefik"
    },
    {
      name = "nextcloud"
    },
    {
      name = "postgres"
    },
  ]
}

resource "docker_network" "nextcloud" {
  name     = "nextcloud"
  internal = true
}

module "nextcloud-redis" {
  name   = "nextcloud-redis"
  source = "modules/container"
  image  = "redis:alpine"

  networks_advanced = [
    {
      name = "nextcloud"
    },
  ]

  # ThisSucks
  web {
    expose = "false"
  }

  resource {
    memory      = 256
    memory_swap = 256
  }
}

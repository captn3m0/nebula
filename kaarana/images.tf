data "docker_registry_image" "wp" {
  name = "wordpress:latest"
}

resource "docker_image" "wp" {
  name          = "wordpress"
  pull_triggers = [data.docker_registry_image.wp.sha256_digest]
}

data "docker_registry_image" "db" {
  name = "mariadb:10.4"
}

resource "docker_image" "db" {
  name          = "mariadb"
  pull_triggers = [data.docker_registry_image.db.sha256_digest]
}

data "docker_registry_image" "traefik" {
  name = "traefik:v2.0"
}

resource "docker_image" "traefik" {
  name          = "traefik"
  pull_triggers = [data.docker_registry_image.db.sha256_digest]
}


resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.latest

  volumes {
    volume_name    = docker_volume.postgres_volume.name
    container_path = "/var/lib/postgresql/data"
    host_path      = docker_volume.postgres_volume.mountpoint
  }

  // This is so that other host-only services can share this
  ports {
    internal = 5432
    external = 5432
    ip       = var.ips["eth0"]
  }

  // This is a not-so-great idea
  // TODO: Figure out a better way to make terraform SSH and then connect to localhost
  ports {
    internal = 5432
    external = 5432
    ip       = var.ips["tun0"]
  }

  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  env = [
    "POSTGRES_PASSWORD=${var.postgres-root-password}",
  ]

  networks = [docker_network.postgres.id, data.docker_network.bridge.id]
}

resource "docker_image" "postgres" {
  name          = data.docker_registry_image.postgres.name
  pull_triggers = [data.docker_registry_image.postgres.sha256_digest]
}

data "docker_registry_image" "postgres" {
  name = "postgres:${var.postgres-version}"
}

data "docker_network" "bridge" {
  name = "bridge"
}


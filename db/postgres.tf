resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.image_id

  command = [
    "postgres",
    "-c",
    "max_connections=250",
    "-c",
    "shared_buffers=500MB",
  ]


  volumes {
    volume_name    = docker_volume.pg_data.name
    container_path = "/var/lib/postgresql/data"
    read_only      = false
  }

  // This is so that other host-only services can share this
  ports {
    internal = 5432
    external = 5432
    ip       = var.ips["eth0"]
  }

  remove_volumes        = false
  memory                = 2048
  memory_swap           = 2048
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

resource "docker_container" "redis" {
  name  = "gitea-redis"
  image = docker_image.redis.image_id

  volumes {
    host_path      = "/mnt/xwing/cache/gitea"
    container_path = "/data"
  }

  memory                = 64
  restart               = "always"
  destroy_grace_seconds = 10
  must_run              = true

  networks = [docker_network.gitea.id]
}

resource "docker_image" "redis" {
  name          = data.docker_registry_image.redis.name
  pull_triggers = [data.docker_registry_image.redis.sha256_digest]
  keep_locally  = true
}


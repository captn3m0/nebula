resource "docker_container" "redis" {
  name  = "gitea-redis"
  image = "${docker_image.redis.latest}"

  volumes {
    host_path      = "/mnt/xwing/cache/gitea"
    container_path = "/data"
  }
}

resource "docker_image" "redis" {
  name          = "${data.docker_registry_image.redis.name}"
  pull_triggers = ["${data.docker_registry_image.redis.sha256_digest}"]
}

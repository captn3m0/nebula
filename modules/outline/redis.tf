resource "docker_container" "redis" {
  name  = "outline-redis"
  image = "${docker_image.redis.image_id}"

  volumes {
    host_path      = "/mnt/xwing/cache/outline"
    container_path = "/data"
  }

  memory                = 128
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  networks = ["${docker_network.outline.id}"]
}

resource "docker_image" "redis" {
  name          = "${data.docker_registry_image.redis.name}"
  pull_triggers = ["${data.docker_registry_image.redis.sha256_digest}"]
  keep_locally  = true
}

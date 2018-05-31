resource "docker_container" "redis" {
  name  = "opml-redis"
  image = "${docker_image.redis.latest}"

  volumes {
    host_path      = "/mnt/xwing/cache/opml-redis"
    container_path = "/data"
  }

  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  networks = ["${docker_network.opml.id}"]
}

resource "docker_image" "redis" {
  name          = "${data.docker_registry_image.redis.name}"
  pull_triggers = ["${data.docker_registry_image.redis.sha256_digest}"]
}

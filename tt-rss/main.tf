data "docker_registry_image" "tt-rss" {
  name = "linuxserver/tt-rss:latest"
}

resource "docker_image" "tt-rss" {
  name          = "${data.docker_registry_image.tt-rss.name}"
  pull_triggers = ["${data.docker_registry_image.tt-rss.sha256_digest}"]
}

resource docker_container "tt-rss" {
  name  = "tt-rss"
  image = "${docker_image.tt-rss.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 80,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  volumes {
    host_path      = "/mnt/xwing/config/tt-rss"
    container_path = "/config"
  }

  links = ["mariadb"]

  env = [
    "TZ=Asia/Kolkata",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

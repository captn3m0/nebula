data "docker_registry_image" "rss-bridge" {
  name = "captn3m0/rss-bridge:latest"
}

resource "docker_image" "rss-bridge" {
  name          = "${data.docker_registry_image.rss-bridge.name}"
  pull_triggers = ["${data.docker_registry_image.rss-bridge.sha256_digest}"]
}

resource "docker_container" "rss-bridge" {
  name  = "rss-bridge"
  image = "${docker_image.rss-bridge.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 80,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  upload {
    content = "${file("${path.module}/whitelist.txt")}"
    file    = "/app/public/whitelist.txt"
  }

  networks = ["${var.traefik-network-id}"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 60
  must_run              = true
}

resource "docker_container" "opml" {
  name  = "opml"
  image = "${docker_image.opml.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 80,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  env = [
    "GITHUB_CLIENT_ID=${var.client-id}",
    "GITHUB_CLIENT_SECRET=${var.client-secret}",
    "REDIS_URL=redis://opml-redis:6379/1",
  ]

  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  networks = ["${docker_network.opml.id}", "${var.traefik-network-id}"]
}

resource "docker_image" "opml" {
  name          = "${data.docker_registry_image.opml.name}"
  pull_triggers = ["${data.docker_registry_image.opml.sha256_digest}"]
}

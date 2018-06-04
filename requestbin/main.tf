data "docker_registry_image" "requestbin" {
  name = "jankysolutions/requestbin:latest"
}

resource "docker_image" "requestbin" {
  name          = "${data.docker_registry_image.requestbin.name}"
  pull_triggers = ["${data.docker_registry_image.requestbin.sha256_digest}"]
}

resource "docker_container" "requestbin" {
  name  = "requestbin"
  image = "${docker_image.requestbin.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 8000,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  networks = ["${var.traefik-network-id}"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

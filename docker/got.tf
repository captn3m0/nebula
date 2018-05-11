data "docker_registry_image" "gotviz" {
  name = "tocttou/gotviz:latest"
}

resource "docker_image" "gotviz" {
  name          = "${data.docker_registry_image.gotviz.name}"
  pull_triggers = ["${data.docker_registry_image.gotviz.sha256_digest}"]
}

resource "docker_container" "gotviz" {
  name  = "gotviz"
  image = "${docker_image.gotviz.latest}"

  labels = "${merge(
    local.traefik_common_labels, map(
      "traefik.port", 8080,
      "traefik.frontend.rule","Host:got-relationships.${var.domain}"
  ))}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 60
  must_run              = true
}

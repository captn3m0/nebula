data "docker_registry_image" "image" {
  name = "${var.image}"
}

resource "docker_image" "image" {
  name          = "${data.docker_registry_image.image.name}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
}

resource "docker_container" "container" {
  name       = "${var.name}"
  image      = "${docker_image.image.latest}"
  ports      = "${var.ports}"
  restart    = "${var.restart}"
  env        = "${var.env}"
  command    = "${var.command}"
  entrypoint = "${var.entrypoint}"
  user       = "${var.user}"
  networks   = ["${var.networks}"]

  labels = "${merge(var.labels, var.expose-web ?
    merge(local.traefik-common-labels, map(
      "traefik.port", var.web-port,
      "traefik.frontend.rule", "Host:${var.web-domain}",
    )) : map())}"

  destroy_grace_seconds = "${var.destroy_grace_seconds}"
  must_run              = "${var.must_run}"
}

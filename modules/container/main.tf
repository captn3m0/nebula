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
  memory     = "${lookup(var.resource, "memory")}"

  // Only add traefik labels if web.expose=true
  // Only add basicauth config if web.basicauth=true
  labels = "${merge(var.labels, lookup(var.web, "expose", "false") ?
    merge(local.traefik-common-labels, map(
      "traefik.port", lookup(var.web, "port", "80"),
      "traefik.frontend.rule", "Host:${lookup(var.web, "host", "")}",
      "traefik.protocol", lookup(var.web, "protocol", "http"),
    )) : map(), lookup(var.web, "basicauth", "false") ? map(
      "traefik.frontend.auth.basic", var.auth-header
    ) : map())}"

  destroy_grace_seconds = "${var.destroy_grace_seconds}"
  must_run              = "${var.must_run}"
}

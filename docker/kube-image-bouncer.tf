data "docker_registry_image" "kib" {
  name = "flavio/kube-image-bouncer:latest"
}

resource "docker_image" "kib" {
  name          = "${data.docker_registry_image.kib.name}"
  pull_triggers = ["${data.docker_registry_image.kib.sha256_digest}"]
}

resource "docker_container" "kib" {
  name  = "kib"
  image = "${docker_image.kib.latest}"

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.port", 1323,
      "traefik.frontend.rule","Host:kib.b88.fun"
  ))}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

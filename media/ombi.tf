data "docker_registry_image" "ombi" {
  name = "linuxserver/ombi:latest"
}

resource "docker_image" "ombi" {
  name          = "${data.docker_registry_image.ombi.name}"
  pull_triggers = ["${data.docker_registry_image.ombi.sha256_digest}"]
}

resource docker_container "ombi" {
  name  = "ombi"
  image = "${docker_image.ombi.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 3579,
      "traefik.frontend.rule","Host:rey.${var.domain}"
  ))}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/ombi"
    container_path = "/config"
  }

  env = [
    "TZ=Asia/Kolkata",
  ]

  links = ["${var.links-emby}"]
}

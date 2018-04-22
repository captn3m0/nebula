data "docker_registry_image" "heimdall" {
  name = "linuxserver/heimdall:latest"
}

resource "docker_image" "heimdall" {
  name          = "${data.docker_registry_image.heimdall.name}"
  pull_triggers = ["${data.docker_registry_image.heimdall.sha256_digest}"]
}

resource "docker_container" "heimdall" {
  name  = "heimdall"
  image = "${docker_image.heimdall.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", "443",
      "traefik.protocol", "https",
      "traefik.frontend.rule","Host:${var.domain}",
      "traefik.frontend.auth.basic", "${var.auth-header}",
  ))}"

  volumes {
    host_path      = "/mnt/xwing/config/heimdall"
    container_path = "/config"
  }

  env = [
    "TZ=Asia/Kolkata",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

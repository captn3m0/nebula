data "docker_registry_image" "radicale" {
  name = "tomsquest/docker-radicale:latest"
}

resource "docker_image" "radicale" {
  name          = "${data.docker_registry_image.radicale.name}"
  pull_triggers = ["${data.docker_registry_image.radicale.sha256_digest}"]
}

resource "docker_container" "radicale" {
  name  = "radicale"
  image = "${docker_image.radicale.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 5232,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  volumes {
    host_path      = "/mnt/xwing/data/radicale"
    container_path = "/data"
  }

  volumes {
    host_path      = "/mnt/xwing/config/radicale"
    container_path = "/config"
  }

  upload {
    content = "${file("${path.module}/config")}"
    file    = "/config/config"
  }

  upload {
    content = "${file("${path.module}/logging.conf")}"
    file    = "/config/logging"
  }

  upload {
    content = "${file("${path.module}/users")}"
    file    = "/config/users"
  }

  networks = ["${var.traefik-network-id}"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

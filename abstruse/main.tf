data "docker_registry_image" "abstruse" {
  name = "bleenco/abstruse"
}

resource "docker_image" "abstruse" {
  name          = "${data.docker_registry_image.abstruse.name}"
  pull_triggers = ["${data.docker_registry_image.abstruse.sha256_digest}"]
}

resource "docker_container" "abstruse" {
  name  = "abstruse"
  image = "${docker_image.abstruse.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 6500,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  volumes {
    host_path      = "/mnt/xwing/config/abstruse"
    container_path = "/root/.abstruse"
  }

  restart               = "unless-stopped"
  destroy_grace_seconds = 60
  must_run              = true
}

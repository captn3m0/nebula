data "docker_registry_image" "jackett" {
  name = "linuxserver/jackett:latest"
}

resource "docker_image" "jackett" {
  name          = "${data.docker_registry_image.jackett.name}"
  pull_triggers = ["${data.docker_registry_image.jackett.sha256_digest}"]
}

resource "docker_container" "jackett" {
  name  = "jackett"
  image = "${docker_image.jackett.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 9117,
      "traefik.frontend.rule","Host:jackett.${var.domain}"
  ))}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/jackett"
    container_path = "/config"
  }

  networks = ["${docker_network.media.id}", "${var.traefik-network-id}"]

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

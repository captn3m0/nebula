data "docker_registry_image" "sonarr" {
  name = "linuxserver/sonarr:latest"
}

resource "docker_image" "sonarr" {
  name          = "${data.docker_registry_image.sonarr.name}"
  pull_triggers = ["${data.docker_registry_image.sonarr.sha256_digest}"]
}

resource "docker_container" "sonarr" {
  name  = "sonarr"
  image = "${docker_image.sonarr.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 8989,
      "traefik.frontend.rule","Host:sonarr.${var.domain}"
  ))}"

  memory                = 512
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/sonarr"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/TV"
    container_path = "/tv"
  }

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  networks = ["${docker_network.media.id}", "${var.traefik-network-id}"]
}

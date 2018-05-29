data "docker_registry_image" "radarr" {
  name = "linuxserver/radarr:latest"
}

resource "docker_image" "radarr" {
  name          = "${data.docker_registry_image.radarr.name}"
  pull_triggers = ["${data.docker_registry_image.radarr.sha256_digest}"]
}

resource "docker_container" "radarr" {
  name  = "radarr"
  image = "${docker_image.radarr.latest}"

  # TODO: wildcard certs needed!
  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 7878,
      "traefik.frontend.rule","Host:radarr.${var.domain}"
  ))}"

  memory                = 512
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/radarr"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Movies"
    container_path = "/movies"
  }

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  networks = ["${docker_network.media.id}"]
}

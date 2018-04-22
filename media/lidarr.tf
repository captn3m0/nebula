data "docker_registry_image" "lidarr" {
  name = "linuxserver/lidarr:latest"
}

resource "docker_image" "lidarr" {
  name          = "${data.docker_registry_image.lidarr.name}"
  pull_triggers = ["${data.docker_registry_image.lidarr.sha256_digest}"]
}

resource docker_container "lidarr" {
  name  = "lidarr"
  image = "${docker_image.lidarr.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 8686,
      "traefik.frontend.rule","Host:lidarr.${var.domain}"
  ))}"

  memory                = 512
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/lidarr"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Music"
    container_path = "/music"
  }

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  links = ["${var.links-emby}", "${var.links-transmission}"]
}

data "docker_registry_image" "mylar" {
  name = "linuxserver/mylar:latest"
}

resource "docker_image" "mylar" {
  name          = "${data.docker_registry_image.mylar.name}"
  pull_triggers = ["${data.docker_registry_image.mylar.sha256_digest}"]
}

resource docker_container "mylar" {
  name  = "mylar"
  image = "${docker_image.mylar.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 8090,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  volumes {
    host_path      = "/mnt/xwing/config/mylar"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL/comics"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/EBooks/Comics"
    container_path = "/comics"
  }

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  links = ["mariadb"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

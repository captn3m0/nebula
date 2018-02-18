data "docker_registry_image" "resilio-sync" {
  name = "linuxserver/resilio-sync:latest"
}

resource "docker_image" "resilio-sync" {
  name          = "${data.docker_registry_image.resilio-sync.name}"
  pull_triggers = ["${data.docker_registry_image.resilio-sync.sha256_digest}"]
}

resource "docker_container" "resilio-sync" {
  name  = "resilio-sync"
  image = "${docker_image.resilio-sync.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true

  ports {
    internal = 8888
    external = 8888
    ip       = "${var.ips["eth0"]}"
  }

  ports {
    internal = 55555
    external = 55555
    ip       = "${var.ips["eth0"]}"
  }

  volumes {
    host_path      = "/mnt/xwing/data/resilio-sync"
    container_path = "/sync"
  }

  volumes {
    host_path      = "/mnt/xwing/config/resilio-sync"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  labels = "${merge(
    var.traefik-labels,
    map(
      "traefik.frontend.rule", "Host:${var.domain}",
      "traefik.port", 8888,
    ))}"
}

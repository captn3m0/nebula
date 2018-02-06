resource docker_container "transmission" {
  name  = "transmission"
  image = "${docker_image.transmission.latest}"

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.port", 9091,
    ))}"

  ports {
    internal = 51413
    external = 51413
    ip       = "${var.ips["eth0"]}"
    protocol = "udp"
  }

  volumes {
    host_path      = "/mnt/xwing/config/transmission"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/data/watch/transmission"
    container_path = "/watch"
  }

  upload {
    content = "${file("${path.module}/conf/transmission.json")}"
    file    = "/config/settings.json"
  }

  env = [
    "PGID=1003",
    "PUID=1000",
    "TZ=Asia/Kolkata",
  ]

  memory                = 1024
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

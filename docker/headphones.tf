resource "docker_container" "headphones" {
  name  = "headphones"
  image = "${docker_image.headphones.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
  memory                = 128

  volumes {
    host_path      = "/mnt/xwing/config/headphones"
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

  upload {
    content = "${file("${path.module}/conf/headphones.ini")}"
    file    = "/config/config.ini"
  }

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.port", 8181,
    ))}"

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

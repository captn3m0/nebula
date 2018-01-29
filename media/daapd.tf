data "docker_registry_image" "daapd" {
  name = "linuxserver/daapd:latest"
}

resource "docker_image" "daapd" {
  name          = "${data.docker_registry_image.daapd.name}"
  pull_triggers = ["${data.docker_registry_image.daapd.sha256_digest}"]
}

resource docker_container "daapd" {
  name  = "daapd"
  image = "${docker_image.daapd.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
  network_mode          = "host"

  volumes {
    host_path      = "/mnt/xwing/config/daapd"
    container_path = "/config"
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
}

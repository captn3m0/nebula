resource "docker_container" "jellyfin" {
  name  = "jellyfin"
  image = "${docker_image.jellyfin.latest}"

  volumes {
    host_path      = "/mnt/xwing/config/jellyfin"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media"
    container_path = "/media"
  }

  labels = "${merge(
    var.traefik-labels,
    map(
      "traefik.frontend.rule", "Host:media.in.${var.domain},media.${var.domain}",
      "traefik.frontend.passHostHeader", "true",
      "traefik.port", 8096,
    ))}"

  networks = ["${docker_network.media.id}", "${var.traefik-network-id}"]

  memory                = 2048
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  # Running as lounge:tatooine
  env = [
    "APP_USER=lounge",
    "APP_UID=1004",
    "APP_GID=1003",
    "APP_CONFIG=/mnt/xwing/config",
    "TZ=Asia/Kolkata",
  ]
}

resource "docker_image" "jellyfin" {
  name          = "${data.docker_registry_image.jellyfin.name}"
  pull_triggers = ["${data.docker_registry_image.jellyfin.sha256_digest}"]
}

data "docker_registry_image" "jellyfin" {
  name = "jellyfin/jellyfin:latest"
}

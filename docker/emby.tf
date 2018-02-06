resource "docker_container" "emby" {
  name  = "emby"
  image = "${docker_image.emby.latest}"

  volumes {
    host_path      = "/mnt/xwing/config/emby"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media"
    container_path = "/media"
  }

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.rule", "Host:emby.in.${var.domain},emby.${var.domain}",
      "traefik.frontend.passHostHeader", "true",
      "traefik.port", 8096,
    ))}"

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
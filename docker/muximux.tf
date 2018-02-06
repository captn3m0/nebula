resource "docker_container" "muximux" {
  name   = "muximux"
  image  = "${docker_image.muximux.latest}"
  memory = 64

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/muximux"
    container_path = "/config"
  }

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.port", 80,
      "traefik.frontend.headers.frameDeny", "true",
      "traefik.frontend.passHostHeader", "false",
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.frontend.rule", "Host:home.in.${var.domain},home.${var.domain}",
    ))}"

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

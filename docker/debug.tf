resource "docker_container" "headerdebug" {
  name  = "headerdebug"
  image = "${docker_image.headerdebug.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true

  memory = 16

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.rule", "Host:debug.in.${var.domain},debug.${var.domain}",
      "traefik.port", 8080,
      "traefik.enable", "true",
    ))}"
}
resource "docker_container" "wiki" {
  name  = "wiki"
  image = "${docker_image.wikijs.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true
  memory                = 300

  upload {
    content = "${file("${path.module}/conf/wiki.yml")}"
    file    = "/var/wiki/config.yml"
  }

  volumes {
    host_path      = "/mnt/xwing/logs/wiki"
    container_path = "/logs"
  }

  volumes {
    host_path      = "/mnt/xwing/data/wiki/repo"
    container_path = "/repo"
  }

  volumes {
    host_path      = "/mnt/xwing/data/wiki/data"
    container_path = "/data"
  }

  upload {
    content = "${file("${path.module}/conf/humans.txt")}"
    file    = "/var/wiki/assets/humans.txt"
  }

  // The last header is a workaround for double header traefik bug
  // This might be actually breaking iframe till the 1.5 Final release.

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.rule", "Host:wiki.${var.domain}",
      "traefik.frontend.passHostHeader", "true",
      "traefik.port", 9999,
      "traefik.frontend.headers.customResponseHeaders", "${var.xpoweredby}||Referrer-Policy:${var.refpolicy}||X-Frame-Options:${var.xfo_allow}",
    ))}"

  links = ["${docker_container.mongorocks.name}"]

  env = [
    "WIKI_ADMIN_EMAIL=me@captnemo.in",
    "SESSION_SECRET=${var.wiki_session_secret}",
  ]
}

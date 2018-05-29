resource "docker_container" "gitea" {
  name  = "gitea"
  image = "${docker_image.gitea.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 3000,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  ports {
    internal = 22
    external = 2222
    ip       = "${var.ips["eth0"]}"
  }

  ports {
    internal = 22
    external = 2222
    ip       = "${var.ips["tun0"]}"
  }

  volumes {
    volume_name    = "${docker_volume.gitea_volume.name}"
    container_path = "/data"
    host_path      = "${docker_volume.gitea_volume.mountpoint}"
  }

  # Logos
  # TODO: Add svg

  upload {
    content = "${file("${path.module}/conf/public/img/gitea-lg.png")}"
    file    = "/data/gitea/public/img/gitea-lg.png"
  }
  upload {
    content = "${file("${path.module}/conf/public/img/gitea-sm.png")}"
    file    = "/data/gitea/public/img/gitea-sm.png"
  }
  upload {
    content = "${file("${path.module}/conf/public/img/gitea-sm.png")}"
    file    = "/data/gitea/public/img/favicon.png"
  }
  upload {
    content = "${file("${path.module}/../docker/conf/humans.txt")}"
    file    = "/data/gitea/public/humans.txt"
  }
  # Extra Links in header
  upload {
    content = "${file("${path.module}/conf/extra_links.tmpl")}"
    file    = "/data/gitea/templates/custom/extra_links.tmpl"
  }
  # This is the main configuration file
  upload {
    content = "${data.template_file.gitea-config-file.rendered}"
    file    = "/data/gitea/conf/app.ini"
  }
  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
  links = [
    "mariadb",
  ]
  networks = ["${docker_network.gitea.id}"]
}

resource "docker_image" "gitea" {
  name          = "${data.docker_registry_image.gitea.name}"
  pull_triggers = ["${data.docker_registry_image.gitea.sha256_digest}"]
}

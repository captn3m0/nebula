data "docker_registry_image" "tinyproxy" {
  name = "captn3m0/tinyproxy:latest"
}

resource "docker_image" "tinyproxy" {
  name          = "${data.docker_registry_image.tinyproxy.name}"
  pull_triggers = ["${data.docker_registry_image.tinyproxy.sha256_digest}"]
}

resource "docker_container" "tinyproxy" {
  name  = "tinyproxy"
  image = "${docker_image.tinyproxy.latest}"

  upload {
    content = "${file("${path.module}/tinyproxy.conf")}"
    file    = "/etc/tinyproxy/tinyproxy.conf"
  }

  upload {
    content = "${file("${path.module}/filter.conf")}"
    file    = "/etc/tinyproxy/filter.conf"
  }

  ports {
    internal = 8888
    external = 8888
    ip       = "${var.ips["tun0"]}"
  }

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

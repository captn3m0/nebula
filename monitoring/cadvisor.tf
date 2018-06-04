resource "docker_container" "cadvisor" {
  name   = "cadvisor"
  image  = "${docker_image.cadvisor.latest}"
  memory = 512

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/"
    container_path = "/rootfs"
    read_only      = true
  }

  volumes {
    host_path      = "/sys"
    container_path = "/sys"
    read_only      = true
  }

  volumes {
    host_path      = "/var/lib/docker"
    container_path = "/var/lib/docker"
    read_only      = true
  }

  volumes {
    host_path      = "/dev/disk"
    container_path = "/dev/disk"
    read_only      = true
  }

  volumes {
    host_path      = "/var/run"
    container_path = "/var/run"
  }

  networks = ["${var.traefik-network-id}"]

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 8080,
      "traefik.frontend.rule","Host:cadvisor.${var.domain}",
      "traefik.frontend.auth.basic", "${var.basic_auth}"
  ))}"
}

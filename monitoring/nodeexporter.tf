resource "docker_container" "nodeexporter" {
  name  = "nodeexporter"
  image = "${docker_image.nodeexporter.latest}"

  volumes {
    host_path      = "/proc"
    container_path = "/host/proc"
  }

  volumes {
    host_path      = "/sys"
    container_path = "/host/sys"
  }

  volumes {
    host_path      = "/"
    container_path = "/rootfs"
    read_only      = true
  }

  command = [
    "--path.procfs=/host/proc",
    "--path.sysfs=/host/sys",
    "--collector.filesystem.ignored-mount-points=\"^/(sys|proc|dev|host|etc)($$|/)\"",
  ]

  networks = ["${docker_network.monitoring.id}"]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

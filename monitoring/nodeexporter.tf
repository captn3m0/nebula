module "nodeexporter" {
  name   = "nodeexporter"
  source = "../modules/container"
  image  = "prom/node-exporter:latest"

  volumes = [
    {
      host_path      = "/proc"
      container_path = "/host/proc"
    },
    {
      host_path      = "/sys"
      container_path = "/host/sys"
    },
    {
      host_path      = "/"
      container_path = "/rootfs"
      read_only      = true
    },
    {
      host_path      = "/mnt/xwing"
      container_path = "/host/mnt"
      read_only      = true
    },
  ]

  command = [
    "--path.procfs=/host/proc",
    "--path.sysfs=/host/sys",
    "--collector.filesystem.ignored-mount-points=\"^/(sys|proc|dev|host|etc)($$|/)\"",
  ]

  networks = [
    "${docker_network.monitoring.id}",
  ]

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

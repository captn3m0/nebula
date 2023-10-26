module "cadvisor" {
  source = "../modules/container"
  name   = "cadvisor"
  image  = "gcr.io/cadvisor/cadvisor"

  resource = {
    memory      = 512
    memory_swap = 512
  }

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
  privileged = true

  volumes = [
    {
      host_path      = "/sys"
      container_path = "/sys"
      read_only      = true
    },
    {
      host_path      = "/"
      container_path = "/rootfs"
      read_only      = true
    },
    {
      host_path      = "/var/lib/docker"
      container_path = "/var/lib/docker"
      read_only      = true
    },
    {
      host_path      = "/dev/disk"
      container_path = "/dev/disk"
      read_only      = true
    },
    {
      host_path      = "/var/run"
      container_path = "/var/run"
      read_only      = true
    },
  ]

  networks = ["monitoring"]

  web = {
    expose = true
    port   = 8080
    auth   = true
  }
}


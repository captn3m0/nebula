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

  labels {
    "traefik.frontend.auth.basic"                      = "${var.basic_auth}"
    "traefik.port"                                     = 8080
    "traefik.enable"                                   = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect"    = "true"
    "traefik.frontend.headers.STSSeconds"              = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains"    = "false"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.browserXSSFilter"        = "true"
    "traefik.frontend.passHostHeader"                  = "true"
    "traefik.frontend.headers.customFrameOptionsValue" = "ALLOW-FROM https://home.bb8.fun/"
    "traefik.frontend.headers.customResponseHeaders"   = "X-Powered-By:Allomancy||X-Server:Blackbox"
  }
}

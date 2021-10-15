// Create a small database network
resource "docker_network" "traefik" {
  name = "traefik"

  labels = {
    internal = "true"
    role     = "ingress"
  }

  internal = true
}

resource "docker_container" "traefik" {
  name  = "traefik"
  image = docker_image.traefik.latest

  # Do not offer HTTP2
  # https://community.containo.us/t/traefikv2-http-2-0/1199
  env = [
    "GODEBUG=http2client=0",
  ]

  upload {
    content = file("${path.module}/traefik.toml")
    file    = "/etc/traefik/traefik.toml"
  }

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
    read_only      = true
  }

  volumes {
    host_path      = "/mnt/disk/traefik"
    container_path = "/acme"
  }

  ports {
    internal = 443
    external = 8443
    ip       = "139.59.22.234"
  }

  ports {
    internal = 80
    external = 80
    ip       = "139.59.22.234"
  }

  memory                = 256
  restart               = "always"
  destroy_grace_seconds = 10
  must_run              = true

  networks_advanced {
    name = "bridge"
  }

  networks_advanced {
    name = "traefik"
  }
}


resource "docker_container" "traefik" {
  name  = "traefik"
  image = "${docker_image.traefik.latest}"

  # Admin Backend
  ports {
    internal  = 1111
    external  = 1111
    ip        = "192.168.1.111"
  }

  # Local Web Server
  ports {
    internal  = 80
    external  = 8888
    ip        = "192.168.1.111"
  }

  # Local Web Server
  ports {
    internal  = 80
    external  = 80
    ip        = "192.168.1.111"
  }

  # Local Web Server (HTTPS)
  ports {
    internal  = 443
    external  = 443
    ip        = "192.168.1.111"
  }

  # Proxied via sydney.captnemo.in
  ports {
    internal  = 443
    external  = 443
    ip        = "10.8.0.14"
  }

  ports {
    internal  = 80
    external  = 80
    ip        = "10.8.0.14"
  }

  upload {
    content = "${file("${path.module}/conf/traefik.toml")}"
    file    = "/etc/traefik/traefik.toml"
  }

  volumes {
    host_path         = "/var/run/docker.sock"
    container_path    = "/var/run/docker.sock"
    read_only         = true
  }

  volumes {
    host_path         = "/mnt/xwing/config/acme"
    container_path    = "/acme"
  }

  memory = 256
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  env = [
    "CLOUDFLARE_EMAIL=${var.cloudflare_email}",
    "CLOUDFLARE_API_KEY=${var.cloudflare_key}"
  ]
}

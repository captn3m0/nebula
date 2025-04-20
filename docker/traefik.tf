resource "docker_container" "traefik" {
  name  = "traefik"
  image = docker_image.traefik17.image_id

  # Local Web Server
  ports {
    internal = 80
    external = 80
    ip       = var.ips["eth0"]
  }

  # Local Web Server (HTTPS)
  ports {
    internal = 443
    external = 443
    ip       = var.ips["eth0"]
  }

  # Proxied via sydney.captnemo.in
  ports {
    internal = 443
    external = 443
    ip       = var.ips["ts"]
  }

  ports {
    internal = 80
    external = 80
    ip       = var.ips["ts"]
  }

  ports {
    internal = 1111
    external = 1111
    ip       = var.ips["eth0"]
  }

  upload {
    content = file("${path.module}/conf/traefik.toml")
    file    = "/etc/traefik/traefik.toml"
  }

  upload {
    content = file(
      "/home/nemo/projects/personal/certs/git.captnemo.in/fullchain.pem",
    )
    file = "/etc/traefik/git.captnemo.in.crt"
  }
  upload {
    content = file(
      "/home/nemo/projects/personal/certs/git.captnemo.in/privkey.pem",
    )
    file = "/etc/traefik/git.captnemo.in.key"
  }

  upload {
    content = file(
      "/home/nemo/projects/personal/certs/tatooine.club/fullchain.pem",
    )
    file = "/etc/traefik/tatooine.club.crt"
  }
  upload {
    content = file(
      "/home/nemo/projects/personal/certs/tatooine.club/privkey.pem",
    )
    file = "/etc/traefik/tatooine.club.key"
  }

  upload {
    content = file(
      "/home/nemo/.acme.sh/*.bb8.fun_ecc/*.bb8.fun.key",
    )
    file = "/etc/traefik/star.bb8.fun.key"
  }

  upload {
    content = file(
      "/home/nemo/.acme.sh/*.bb8.fun_ecc/fullchain.cer",
    )
    file = "/etc/traefik/star.bb8.fun.crt"
  }



  upload {
    content = file(
      "/home/nemo/projects/personal/certs/rss.captnemo.in/fullchain.pem",
    )
    file = "/etc/traefik/rss.captnemo.in.crt"
  }

  upload {
    content = file(
      "/home/nemo/projects/personal/certs/rss.captnemo.in/privkey.pem",
    )
    file = "/etc/traefik/rss.captnemo.in.key"
  }

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
    read_only      = true
  }

  volumes {
    host_path      = "/mnt/xwing/config/acme"
    container_path = "/acme"
  }

  memory                = 256
  restart               = "always"
  destroy_grace_seconds = 10
  must_run              = true

  // `bridge` is auto-connected for now
  // https://github.com/terraform-providers/terraform-provider-docker/issues/10
  networks_advanced {
    name = "traefik"
  }

  networks_advanced {
    name = "bridge"
  }

}

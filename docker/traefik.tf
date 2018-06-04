resource "docker_container" "traefik" {
  name  = "traefik"
  image = "${docker_image.traefik16.latest}"

  # Admin Backend
  ports {
    internal = 1111
    external = 1111
    ip       = "${var.ips["eth0"]}"
  }

  ports {
    internal = 1111
    external = 1111
    ip       = "${var.ips["tun0"]}"
  }

  # Local Web Server
  ports {
    internal = 80
    external = 80
    ip       = "${var.ips["eth0"]}"
  }

  # Local Web Server (HTTPS)
  ports {
    internal = 443
    external = 443
    ip       = "${var.ips["eth0"]}"
  }

  # Proxied via sydney.captnemo.in
  ports {
    internal = 443
    external = 443
    ip       = "${var.ips["tun0"]}"
  }

  ports {
    internal = 80
    external = 80
    ip       = "${var.ips["tun0"]}"
  }

  upload {
    content = "${file("${path.module}/conf/traefik.toml")}"
    file    = "/etc/traefik/traefik.toml"
  }

  upload {
    content = "${file("/home/nemo/projects/personal/certs/git.captnemo.in/fullchain.pem")}"
    file    = "/etc/traefik/git.captnemo.in.crt"
  }

  upload {
    content = "${file("/home/nemo/projects/personal/certs/git.captnemo.in/privkey.pem")}"
    file    = "/etc/traefik/git.captnemo.in.key"
  }

  upload {
    content = "${file("/home/nemo/projects/personal/certs/rss.captnemo.in/fullchain.pem")}"
    file    = "/etc/traefik/rss.captnemo.in.crt"
  }

  upload {
    content = "${file("/home/nemo/projects/personal/certs/rss.captnemo.in/privkey.pem")}"
    file    = "/etc/traefik/rss.captnemo.in.key"
  }

  upload {
    content = "${file("/home/nemo/projects/personal/certs/emby.in.bb8.fun/privkey.pem")}"
    file    = "/etc/traefik/emby.in.bb8.fun.key"
  }

  upload {
    content = "${file("/home/nemo/projects/personal/certs/emby.in.bb8.fun/fullchain.pem")}"
    file    = "/etc/traefik/emby.in.bb8.fun.crt"
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
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  // `bridge` is auto-connected for now
  // https://github.com/terraform-providers/terraform-provider-docker/issues/10
  //
  // The extra IDs are till https://github.com/containous/traefik/issues/3429 is resolved
  // gitea, media, opml, monitoring
  networks = [
    "${docker_network.traefik.id}",
    "31efc1966139",
    "f0d3bbcf75dd",
    "aad198ad4ba8",
    "021125972c4b",
  ]

  env = [
    "CLOUDFLARE_EMAIL=${var.cloudflare_email}",
    "CLOUDFLARE_API_KEY=${var.cloudflare_key}",
  ]
}

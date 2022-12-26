resource "docker_container" "wp" {
  image = docker_image.wp.image_id
  name  = "kaarana-wordpress"

  restart  = "always"
  must_run = true

  labels = {
    "traefik.enable"                   = "true"
    "traefik.tcp.routers.kaarana.rule" = "HostSNI(`kaarana.captnemo.in`)"
    "traefik.tcp.routers.kaarana.tls"  = "true"
    # "traefik.tcp.routers.kaarana.tls.options"                 = "foo"
    "traefik.tcp.services.wordpress.loadbalancer.server.port" = "80"
    # "traefik.tcp.routers.kaarana.entrypoints"                 = "web-secure"
    "traefik.tcp.routers.kaarana.tls.certResolver"    = "default"
    "traefik.tcp.routers.kaarana.tls.domains[0].main" = "kaarana.captnemo.in"
  }

  env = [
    "WORDPRESS_DB_HOST=${local.db_hostname}",
    "WORDPRESS_DB_USER=${local.username}",
    "WORDPRESS_DB_PASSWORD=${var.db_password}",
    "WORDPRESS_DB_NAME=${local.database}",
    "WORDPRESS_TABLE_PREFIX=",
  ]

  volumes {
    host_path      = "/mnt/disk/kaarana-wp"
    container_path = "/var/www/html"
  }

  ports {
    internal = 80
    external = 8213
    ip       = "10.8.0.1"
  }

  networks = ["bridge", "kaarana-db"]
}


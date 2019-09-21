resource "docker_container" "wp" {
  image = "${docker_image.wp.latest}"
  name  = "kaarana-wordpress"

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

  networks_advanced = [
    {
      name = "kaarana-db"
    },
    {
      // TODO: Once configuration/plugins have stabilized
      // remove internet access from wordpress
      name = "bridge"
    },
  ]
}

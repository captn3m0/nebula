resource "docker_container" "mongorocks" {
  name  = "mongorocks"
  image = "${docker_image.mongorocks.latest}"

  restart = "unless-stopped"
  destroy_grace_seconds = 30
  must_run = true
  memory = 256

  volumes {
    volume_name    = "${docker_volume.mongorocks_data_volume.name}"
    container_path = "/data/db"
    host_path      = "${docker_volume.mongorocks_data_volume.mountpoint}"
  }

  env = [
    "AUTH=no",
    "DATABASE=wiki",
    "OPLOG_SIZE=50",
  ]
}

resource "docker_container" "mariadb" {
  name  = "mariadb"
  image = "${docker_image.mariadb.latest}"

  volumes {
    volume_name    = "${docker_volume.mariadb_volume.name}"
    container_path = "/var/lib/mysql"
    host_path      = "${docker_volume.mariadb_volume.mountpoint}"
  }

  ports {
    internal = 3306
    external = 3306
    ip       = "192.168.1.111"
  }

  memory = 512
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
  ]
}

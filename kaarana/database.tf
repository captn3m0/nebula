// Create a small database network
resource "docker_network" "kaarana-db" {
  name = "kaarana-db"

  labels = {
    internal = "true"
    role     = "database"
  }

  internal = true

  ipam_config {
    subnet  = "172.20.0.0/29"
    gateway = "172.20.0.1"
  }
}

// Run a small mySQL container in this subnet

resource "docker_container" "mysql" {
  image    = docker_image.db.image_id
  name     = "kaarana-mariadb"
  restart  = "always"
  must_run = true

  env = [
    "MYSQL_ROOT_PASSWORD=${var.root_db_password}",
    "MYSQL_USER=${local.username}",
    "MYSQL_PASSWORD=${var.db_password}",
    "MYSQL_DATABASE=${local.database}",
  ]

  volumes {
    host_path      = "/mnt/disk/kaarana-db"
    container_path = "/var/lib/mysql"
  }

  networks = ["kaarana-db"]
}


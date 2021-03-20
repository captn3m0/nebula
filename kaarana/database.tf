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
  image    = docker_image.db.latest
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

  networks_advanced {
    name = "kaarana-db"
    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    aliases = [local.db_hostname]
  }
}


resource "docker_container" "mariadb" {
  name  = "mariadb"
  image = "${docker_image.mariadb.latest}"

  volumes {
    volume_name    = "${docker_volume.mariadb_volume.name}"
    container_path = "/var/lib/mysql"
    host_path      = "${docker_volume.mariadb_volume.mountpoint}"
  }

  // This is so that other host-only services can share this
  ports {
    internal = 3306
    external = 3306
    ip       = "${var.ips["eth0"]}"
  }

  // This is a not-so-great idea
  // TODO: Figure out a better way to make terraform SSH and then connect to localhost
  ports {
    internal = 3306
    external = 3306
    ip       = "${var.ips["tun0"]}"
  }

  memory                = 512
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
  ]

  command = [
    "--version=${var.mariadb-version}-MariaDB",
  ]
}

resource "docker_image" "mariadb" {
  name          = "${data.docker_registry_image.mariadb.name}"
  pull_triggers = ["${data.docker_registry_image.mariadb.sha256_digest}"]
}

data "docker_registry_image" "mariadb" {
  name = "mariadb:${var.mariadb-version}"
}

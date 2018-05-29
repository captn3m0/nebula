resource "docker_container" "mongorocks" {
  name  = "mongorocks"
  image = "${docker_image.percona-mongodb-server.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true
  memory                = 256

  volumes {
    volume_name    = "${docker_volume.mongorocks_data_volume.name}"
    container_path = "/data/db"
    host_path      = "${docker_volume.mongorocks_data_volume.mountpoint}"
  }

  command = [
    "--storageEngine=rocksdb",
    "--httpinterface",
    "--rest",
    "--master",
  ]
}

resource "docker_image" "percona-mongodb-server" {
  name          = "${data.docker_registry_image.percona-mongodb-server.name}"
  pull_triggers = ["${data.docker_registry_image.percona-mongodb-server.sha256_digest}"]
}

# Database versions shouldn't be upgraded
data "docker_registry_image" "percona-mongodb-server" {
  name = "percona/percona-server-mongodb:3.4"
}

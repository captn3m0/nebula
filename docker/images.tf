resource "docker_image" "emby" {
  name          = "${data.docker_registry_image.emby.name}"
  pull_triggers = ["${data.docker_registry_image.emby.sha256_digest}"]
}

resource "docker_image" "mariadb" {
  name          = "${data.docker_registry_image.mariadb.name}"
  pull_triggers = ["${data.docker_registry_image.mariadb.sha256_digest}"]
}

resource "docker_image" "transmission" {
  name          = "${data.docker_registry_image.transmission.name}"
  pull_triggers = ["${data.docker_registry_image.transmission.sha256_digest}"]
}

resource "docker_image" "traefik16" {
  name          = "${data.docker_registry_image.traefik.name}"
  pull_triggers = ["${data.docker_registry_image.traefik.sha256_digest}"]
}

resource "docker_image" "wikijs" {
  name          = "${data.docker_registry_image.wikijs.name}"
  pull_triggers = ["${data.docker_registry_image.wikijs.sha256_digest}"]
}

resource "docker_image" "percona-mongodb-server" {
  name          = "${data.docker_registry_image.percona-mongodb-server.name}"
  pull_triggers = ["${data.docker_registry_image.percona-mongodb-server.sha256_digest}"]
}

resource "docker_image" "ubooquity" {
  name          = "${data.docker_registry_image.ubooquity.name}"
  pull_triggers = ["${data.docker_registry_image.ubooquity.sha256_digest}"]
}

# Helps debug traefik reverse proxy headers
# Highly recommended!
# resource "docker_image" "headerdebug" {
#   name          = "${data.docker_registry_image.headerdebug.name}"
#   pull_triggers = ["${data.docker_registry_image.headerdebug.sha256_digest}"]
# }

resource "docker_image" "lychee" {
  name          = "${data.docker_registry_image.lychee.name}"
  pull_triggers = ["${data.docker_registry_image.lychee.sha256_digest}"]
}

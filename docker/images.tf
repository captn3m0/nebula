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

resource "docker_image" "flexget" {
  name          = "${data.docker_registry_image.flexget.name}"
  pull_triggers = ["${data.docker_registry_image.flexget.sha256_digest}"]
}

resource "docker_image" "couchpotato" {
  name          = "${data.docker_registry_image.couchpotato.name}"
  pull_triggers = ["${data.docker_registry_image.couchpotato.sha256_digest}"]
}

resource "docker_image" "traefik" {
  name          = "${data.docker_registry_image.traefik.name}"
  pull_triggers = ["${data.docker_registry_image.traefik.sha256_digest}"]
}

resource "docker_image" "gitea" {
  name          = "${data.docker_registry_image.gitea.name}"
  pull_triggers = ["${data.docker_registry_image.gitea.sha256_digest}"]
}

resource "docker_image" "sickrage" {
  name          = "${data.docker_registry_image.sickrage.name}"
  pull_triggers = ["${data.docker_registry_image.sickrage.sha256_digest}"]
}

resource "docker_image" "airsonic" {
  name          = "${data.docker_registry_image.airsonic.name}"
  pull_triggers = ["${data.docker_registry_image.airsonic.sha256_digest}"]
}

resource "docker_image" "wikijs" {
  name          = "${data.docker_registry_image.wikijs.name}"
  pull_triggers = ["${data.docker_registry_image.wikijs.sha256_digest}"]
}

resource "docker_image" "mongo" {
  name          = "${data.docker_registry_image.mongo.name}"
  pull_triggers = ["${data.docker_registry_image.mongo.sha256_digest}"]
}

resource "docker_image" "headphones" {
  name          = "${data.docker_registry_image.headphones.name}"
  pull_triggers = ["${data.docker_registry_image.headphones.sha256_digest}"]
}

resource "docker_image" "muximux" {
  name          = "${data.docker_registry_image.muximux.name}"
  pull_triggers = ["${data.docker_registry_image.muximux.sha256_digest}"]
}

resource "docker_image" "ubooquity" {
  name          = "${data.docker_registry_image.ubooquity.name}"
  pull_triggers = ["${data.docker_registry_image.ubooquity.sha256_digest}"]
}

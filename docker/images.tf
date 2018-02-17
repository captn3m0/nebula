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

resource "docker_image" "traefik" {
  name          = "${data.docker_registry_image.traefik.name}"
  pull_triggers = ["${data.docker_registry_image.traefik.sha256_digest}"]
}

resource "docker_image" "airsonic" {
  name          = "${data.docker_registry_image.airsonic.name}"
  pull_triggers = ["${data.docker_registry_image.airsonic.sha256_digest}"]
}

resource "docker_image" "wikijs" {
  name          = "${data.docker_registry_image.wikijs.name}"
  pull_triggers = ["${data.docker_registry_image.wikijs.sha256_digest}"]
}

# Attempting to use mongorocks to work around reboot issue
# Hoping that this will not face reboot-recovery issues
# Wrote about this: https://captnemo.in/blog/2017/12/18/home-server-learnings/
resource "docker_image" "mongorocks" {
  name          = "${data.docker_registry_image.mongorocks.name}"
  pull_triggers = ["${data.docker_registry_image.mongorocks.sha256_digest}"]
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

# Helps debug traefik reverse proxy headers
# Highly recommended!
resource "docker_image" "headerdebug" {
  name          = "${data.docker_registry_image.headerdebug.name}"
  pull_triggers = ["${data.docker_registry_image.headerdebug.sha256_digest}"]
}

resource "docker_image" "lychee" {
  name          = "${data.docker_registry_image.lychee.name}"
  pull_triggers = ["${data.docker_registry_image.lychee.sha256_digest}"]
}

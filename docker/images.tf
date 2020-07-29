resource "docker_image" "traefik17" {
  name          = "${data.docker_registry_image.traefik.name}"
  pull_triggers = ["${data.docker_registry_image.traefik.sha256_digest}"]
}

resource "docker_image" "wikijs" {
  name          = "${data.docker_registry_image.wikijs.name}"
  pull_triggers = ["${data.docker_registry_image.wikijs.sha256_digest}"]
}

resource "docker_image" "ubooquity" {
  name          = "${data.docker_registry_image.ubooquity.name}"
  pull_triggers = ["${data.docker_registry_image.ubooquity.sha256_digest}"]
}

# resource "docker_image" "lychee" {
#   name          = "${data.docker_registry_image.lychee.name}"
#   pull_triggers = ["${data.docker_registry_image.lychee.sha256_digest}"]
# }

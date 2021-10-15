data "docker_registry_image" "image" {
  name = var.image
}

resource "docker_image" "image" {
  name          = var.image
  pull_triggers = [data.docker_registry_image.image.sha256_digest]
  keep_locally  = var.keep_image
}

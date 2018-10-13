variable "image" {
  description = "image to use"
}

data "docker_registry_image" "image" {
  name = "${var.image}"
}

resource "docker_image" "image" {
  name          = "${data.docker_registry_image.image.name}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
}

output "image" {
  value = "${docker_image.image.latest}"
}

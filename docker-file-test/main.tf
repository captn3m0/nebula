data "docker_registry_image" "docker-file-test" {
  name = "nginx:latest"
}

resource "docker_image" "docker-file-test" {
  name          = "${data.docker_registry_image.docker-file-test.name}"
  pull_triggers = ["${data.docker_registry_image.docker-file-test.sha256_digest}"]
}

resource docker_container "docker-file-test" {
  name  = "docker-file-test"
  image = "${docker_image.docker-file-test.latest}"

  upload {
    content = "${file("${path.module}/files/1.txt")}"

    file = "/var/1.txt"
  }
}

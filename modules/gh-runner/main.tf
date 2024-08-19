resource "docker_image" "gh-runner" {
  name          = data.docker_registry_image.runner.name
  pull_triggers = [data.docker_registry_image.runner.sha256_digest]
  keep_locally  = true
}

data "docker_registry_image" "runner" {
  name = "ghcr.io/actions/actions-runner:${var.runner_version}"
}

resource "docker_container" "gh-runner" {
  name  = "gh-runner-${var.name}"
  image = docker_image.gh-runner.latest
  command = [
    "sh",
    "-c",
    "./config.sh --name ${var.name} --url ${var.url} --replace --token ${var.token} --unattended && ./run.sh"
  ]
  memory                = 2048
  restart               = "always"
  destroy_grace_seconds = 10
  must_run              = true
}

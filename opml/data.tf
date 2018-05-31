data "docker_registry_image" "opml" {
  name = "captn3m0/opml-gen:latest"
}

data "docker_registry_image" "redis" {
  name = "redis:alpine"
}

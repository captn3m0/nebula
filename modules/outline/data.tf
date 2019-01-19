data "docker_registry_image" "redis" {
  name = "redis:alpine"
}

data "docker_network" "postgres" {
  name = "postgres"
}

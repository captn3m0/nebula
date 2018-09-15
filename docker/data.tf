data "docker_registry_image" "traefik" {
  # Critical and I like upgrading it
  # for updating config for new features
  name = "traefik:1.7-alpine"
}

data "docker_registry_image" "wikijs" {
  name = "requarks/wiki:latest"
}

data "docker_registry_image" "ubooquity" {
  name = "linuxserver/ubooquity:latest"
}

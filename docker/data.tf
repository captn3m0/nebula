data "docker_registry_image" "traefik" {
  name = "traefik:1.7"
}

data "docker_registry_image" "ubooquity" {
  name = "linuxserver/ubooquity:latest"
}

data "docker_registry_image" "lychee" {
  name = "linuxserver/lychee:latest"
}


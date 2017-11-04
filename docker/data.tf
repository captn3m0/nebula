data "docker_registry_image" "mariadb" {
  name = "mariadb:10.3"
}

data "docker_registry_image" "emby" {
  name = "emby/embyserver:latest"
}

data "docker_registry_image" "transmission" {
  name = "linuxserver/transmission:latest"
}

data "docker_registry_image" "flexget" {
  name = "cpoppema/docker-flexget"
}

data "docker_registry_image" "couchpotato" {
  name = "linuxserver/couchpotato:latest"
}

data "docker_registry_image" "traefik" {
  name = "traefik:latest"
}
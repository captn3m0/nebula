# Database versions shouldn't be upgraded

data "docker_registry_image" "mariadb" {
  name = "mariadb:10.3"
}
# This is a lighter image, than the official one
data "docker_registry_image" "mongo" {
  name = "mvertes/alpine-mongo:3.4.10-0"
}

# Leave all other apps at latesst

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
  name = "traefik:cancoillotte-alpine"
}

# The gitea latest is built against master
# so can't use that, and 1.3 isn't released yet
# https://github.com/go-gitea/gitea/releases
data "docker_registry_image" "gitea" {
  name = "gitea/gitea:1.3.0-rc1"
}

data "docker_registry_image" "sickrage" {
  name = "linuxserver/sickrage:latest"
}

data "docker_registry_image" "airsonic" {
  name = "airsonic/airsonic:latest"
}

data "docker_registry_image" "wikijs" {
  name = "requarks/wiki:latest"
}

data "docker_registry_image" "headphones" {
  name = "linuxserver/headphones:latest"
}

data "docker_registry_image" "muximux" {
  name = "linuxserver/muximux:latest"
}

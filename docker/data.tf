# Database versions shouldn't be upgraded

data "docker_registry_image" "mariadb" {
  name = "mariadb:10.3"
}

data "docker_registry_image" "mongorocks" {
  name = "jadsonlourenco/mongo-rocks:latest"
}

# Leave all other apps at latesst

data "docker_registry_image" "emby" {
  name = "emby/embyserver:latest"
}

data "docker_registry_image" "transmission" {
  name = "linuxserver/transmission:latest"
}

data "docker_registry_image" "couchpotato" {
  name = "linuxserver/couchpotato:latest"
}

data "docker_registry_image" "traefik" {
  name = "traefik:cancoillotte-alpine"
}

# https://github.com/go-gitea/gitea/releases
data "docker_registry_image" "gitea" {
  name = "gitea/gitea:1.3.2"
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

data "docker_registry_image" "ubooquity" {
  name = "linuxserver/ubooquity:latest"
}

data "docker_registry_image" "headerdebug" {
  name = "brndnmtthws/nginx-echo-headers:latest"
}

data "docker_registry_image" "cadvisor" {
  name = "google/cadvisor:latest"
}

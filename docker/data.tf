# Database versions shouldn't be upgraded

data "docker_registry_image" "mariadb" {
  name = "mariadb:${var.mariadb-version}"
}

data "docker_registry_image" "percona-mongodb-server" {
  name = "percona/percona-server-mongodb:3.4"
}

data "docker_registry_image" "traefik" {
  # Critical and I like upgrading it
  # for updating config for new features
  name = "traefik:1.6.0-rc5-alpine"
}

# YOLO everything else
data "docker_registry_image" "emby" {
  name = "emby/embyserver:latest"
}

data "docker_registry_image" "transmission" {
  name = "linuxserver/transmission:latest"
}

data "docker_registry_image" "wikijs" {
  name = "requarks/wiki:latest"
}

data "docker_registry_image" "ubooquity" {
  name = "linuxserver/ubooquity:latest"
}

data "docker_registry_image" "headerdebug" {
  name = "brndnmtthws/nginx-echo-headers:latest"
}

data "docker_registry_image" "lychee" {
  name = "linuxserver/lychee:latest"
}

resource docker_container "transmission" {
  name  = "transmission"
  image = "${docker_image.transmission.latest}"

  labels {
    "traefik.port" = 9091
    "traefik.enable" = "true"
  }

  ports {
    internal = 51413
    external = 51413
    ip       = "192.168.1.111"
    protocol = "udp"
  }

  volumes {
    host_path      = "/mnt/xwing/config/transmission"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/data/watch/transmission"
    container_path = "/watch"
  }

  env = [
    "PGID=1003",
    "PUID=1000",
    "TZ=Asia/Kolkata",
  ]

  memory = 256
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true
}

resource docker_container "gitea" {
  name  = "gitea"
  image = "${docker_image.gitea.latest}"

  labels {
    "traefik.port" = 3000
    "traefik.enable" = "true"
  }

  ports {
    internal = 22
    external = 2222
    ip       = "192.168.1.111"
  }

  ports {
    internal = 22
    external = 2222
    ip       = "10.8.0.14"
  }

  volumes {
    volume_name    = "${docker_volume.gitea_volume.name}"
    container_path = "/data"
    host_path      = "${docker_volume.gitea_volume.mountpoint}"
  }

  memory = 256
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true
}

resource "docker_container" "mariadb" {
  name  = "mariadb"
  image = "${docker_image.mariadb.latest}"

  volumes {
    volume_name    = "${docker_volume.mariadb_volume.name}"
    container_path = "/var/lib/mysql"
    host_path      = "${docker_volume.mariadb_volume.mountpoint}"
  }

  ports {
    internal = 3306
    external = 3306
    ip       = "192.168.1.111"
  }

  memory = 512
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
  ]
}

resource "docker_container" "emby" {
  name  = "emby"
  image = "${docker_image.emby.latest}"

  volumes {
    host_path      = "/mnt/xwing/config/emby"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media"
    container_path = "/media"
  }

  labels {
    "traefik.port" = 8096
    "traefik.enable" = "true"
  }

  memory = 2048
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  # Running as lounge:tatooine
  env = [
    "APP_USER=lounge",
    "APP_UID=1004",
    "APP_GID=1003",
    "APP_CONFIG=/mnt/xwing/config",
    "TZ=Asia/Kolkata",
  ]
}

resource "docker_container" "flexget" {
  name  = "flexget"
  image = "${docker_image.flexget.latest}"

  volumes {
    host_path      = "/mnt/xwing/config/flexget"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/TV"
    container_path = "/tv"
  }

  labels {
    "traefik.port" = 5050
    "traefik.enable" = "true"
  }

  memory = 256
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  # Running as lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "WEB_PASSWD=${var.web_password}",
    "TORRENT_PLUGIN=transmission",
    "FLEXGET_LOG_LEVEL=info",
  ]
}

resource "docker_container" "couchpotato" {
  name  = "couchpotato"
  image = "${docker_image.couchpotato.latest}"

  volumes {
    host_path      = "/mnt/xwing/config/couchpotato"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Movies"
    container_path = "/movies"
  }

  labels {
    "traefik.port" = 5050
    "traefik.enable" = "true"
  }

  memory = 256
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  # Running as lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

resource "docker_container" "traefik" {
  name  = "traefik"
  image = "${docker_image.traefik.latest}"

  ports {
    internal  = 1111
    external  = 1111
    ip        = "192.168.1.111"
  }

  ports {
    internal  = 80
    external  = 8888
    ip        = "192.168.1.111"
  }

  upload {
    content = <<EOF
[web]
address = ":1111"
[docker]
domain = "in.bb8.fun,bb8.fun"
watch = true
exposedbydefault = false
EOF
    file = "/etc/traefik/traefik.toml"
  }

  volumes {
    host_path         = "/var/run/docker.sock"
    container_path    = "/var/run/docker.sock"
  }

  memory = 256
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true
}


resource "docker_container" "sickrage" {
  name  = "sickrage"
  image = "${docker_image.sickrage.latest}"

  volumes {
    host_path      = "/mnt/xwing/config/sickrage"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/TV"
    container_path = "/tv"
  }

  labels {
    "traefik.port" = 8081
    "traefik.enable" = "true"
  }

  env = [
    "PGID=1003",
    "PUID=1000",
    "TZ=Asia/Kolkata",
  ]
}
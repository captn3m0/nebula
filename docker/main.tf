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

  upload {
    content = "${file("${path.module}/conf/transmission.json")}"
    file    = "/config/settings.json"
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

  # Admin Backend
  ports {
    internal  = 1111
    external  = 1111
    ip        = "192.168.1.111"
  }

  # Local Web Server
  ports {
    internal  = 80
    external  = 8888
    ip        = "192.168.1.111"
  }

  # Local Web Server (HTTPS)
  ports {
    internal  = 443
    external  = 443
    ip        = "192.168.1.111"
  }

  # Proxied via sydney.captnemo.in
  ports {
    internal  = 443
    external  = 443
    ip        = "10.8.0.14"
  }

  ports {
    internal  = 80
    external  = 80
    ip        = "10.8.0.14"
  }

  upload {
    content = "${file("${path.module}/conf/traefik.toml")}"
    file    = "/etc/traefik/traefik.toml"
  }

  volumes {
    host_path         = "/var/run/docker.sock"
    container_path    = "/var/run/docker.sock"
  }

  volumes {
    host_path         = "/mnt/xwing/config/acme"
    container_path    = "/acme"
  }

  memory = 256
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  env = [
    "CLOUDFLARE_EMAIL=${var.cloudflare_email}",
    "CLOUDFLARE_API_KEY=${var.cloudflare_key}"
  ]
}


resource "docker_container" "airsonic" {
  name  = "airsonic"
  image = "${docker_image.airsonic.latest}"

  restart = "unless-stopped"
  destroy_grace_seconds = 30
  must_run = true
  user = "1004"

  volumes {
    host_path      = "/mnt/xwing/config/airsonic/data"
    container_path = "/airsonic/data"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Music"
    container_path = "/airsonic/music"
  }

  volumes {
    host_path      = "/mnt/xwing/config/airsonic/playlists"
    container_path = "/airsonic/playlists"
  }

  volumes {
    host_path      = "/mnt/xwing/config/airsonic/podcasts"
    container_path = "/airsonic/podcasts"
  }

  labels {
    "traefik.port" = 4040
    "traefik.enable" = "true"
  }
}

resource "docker_container" "sickrage" {
  name  = "sickrage"
  image = "${docker_image.sickrage.latest}"

  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

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

resource "docker_container" "headphones" {
  name  = "headphones"
  image = "${docker_image.headphones.latest}"

  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  volumes {
    host_path      = "/mnt/xwing/config/headphones"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/DL"
    container_path = "/downloads"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Music"
    container_path = "/music"
  }

  labels {
    "traefik.port" = 8181
    "traefik.enable" = "true"
  }

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

resource "docker_container" "wiki" {
  name  = "wiki"
  image = "${docker_image.wikijs.latest}"

  # This is the wiki user account
  user  = "1006"
  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  upload {
    content = "${file("${path.module}/conf/wiki.yml")}"
    file    = "/var/wiki/config.yml"
  }

  volumes {
    host_path       = "/mnt/xwing/data/wiki/data"
    container_path = "/data"
  }

  volumes {
    host_path       = "/mnt/xwing/data/wiki/repo"
    container_path  = "/repo"
  }

  labels {
    "traefik.port" = 3000
    "traefik.enable" = "true"
  }

  env = [
    "WIKI_ADMIN_EMAIL=me@captnemo.in",
  ]

  links = ["mongo"]
}

resource "docker_container" "mongo" {
  name  = "mongo"
  image = "${docker_image.mongo.latest}"

  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true

  volumes {
    volume_name    = "${docker_volume.mongo_data_volume.name}"
    container_path = "/data/db"
    host_path      = "${docker_volume.mongo_data_volume.mountpoint}"
  }
}

resource "docker_container" "muximux" {
  name  = "muximux"
  image = "${docker_image.muximux.latest}"

  restart = "unless-stopped"
  destroy_grace_seconds = 10
  must_run = true


  volumes {
    host_path       = "/mnt/xwing/config/muximux"
    container_path  = "/config"
  }

  labels {
    "traefik.port" = 80
    "traefik.enable" = "true"
  }

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

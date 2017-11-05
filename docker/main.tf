resource "docker_image" "emby" {
  name          = "${data.docker_registry_image.emby.name}"
  pull_triggers = ["${data.docker_registry_image.emby.sha256_digest}"]
}

resource "docker_image" "mariadb" {
  name          = "${data.docker_registry_image.mariadb.name}"
  pull_triggers = ["${data.docker_registry_image.mariadb.sha256_digest}"]
}

resource "docker_image" "transmission" {
  name          = "${data.docker_registry_image.transmission.name}"
  pull_triggers = ["${data.docker_registry_image.transmission.sha256_digest}"]
}

resource "docker_image" "flexget" {
  name          = "${data.docker_registry_image.flexget.name}"
  pull_triggers = ["${data.docker_registry_image.flexget.sha256_digest}"]
}

resource "docker_image" "couchpotato" {
  name          = "${data.docker_registry_image.couchpotato.name}"
  pull_triggers = ["${data.docker_registry_image.couchpotato.sha256_digest}"]
}

resource "docker_image" "traefik" {
  name          = "${data.docker_registry_image.traefik.name}"
  pull_triggers = ["${data.docker_registry_image.traefik.sha256_digest}"]
}

resource "docker_volume" "mariadb_volume" {
  name = "mariadb_volume"
}

resource docker_container "transmission" {
  name  = "transmission"
  image = "${docker_image.transmission.latest}"

  ports {
    internal = 9091
    external = 9091
    ip       = "192.168.1.111"
  }

  ports {
    internal = 9091
    external = 9091
    ip       = "10.8.0.14"
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

  memory = 512

  restart = "on-failure"
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

  restart = "on-failure"

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

  ports {
    internal = 8096
    external = 8096
    ip       = "0.0.0.0"
  }

  memory = 512

  restart = "on-failure"

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

  ports {
    internal = 5050
    external = 5050
    ip       = "0.0.0.0"
  }

  memory = 512

  restart = "on-failure"

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

  ports {
    internal = 5050
    external = 5051
    ip       = "0.0.0.0"
  }

  memory = 512

  restart = "on-failure"

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

  provisioner "file" {
    source      = "./docker/conf/traefik.toml"
    destination = "/mnt/xwing/config/traefik/traefik.toml"

    connection {
      type     = "ssh"
      user     = "nemo"
      password = ""
      host     = "192.168.1.111"
      timeout  = 5
    }
  }

  volumes {
    host_path         = "/mnt/xwing/config/traefik"
    container_path    = "/etc/traefik"
  }

  volumes {
    host_path         = "/var/run/docker.sock"
    container_path    = "/var/run/docker.sock"
  }
}

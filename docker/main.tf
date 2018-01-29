resource docker_container "transmission" {
  name  = "transmission"
  image = "${docker_image.transmission.latest}"

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.port", 9091,
    ))}"

  ports {
    internal = 51413
    external = 51413
    ip       = "${var.ips["eth0"]}"
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

  memory                = 1024
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
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

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.rule", "Host:emby.in.${var.domain},emby.${var.domain}",
      "traefik.frontend.passHostHeader", "true",
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.port", 8096,
    ))}"

  memory                = 2048
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  # Running as lounge:tatooine
  env = [
    "APP_USER=lounge",
    "APP_UID=1004",
    "APP_GID=1003",
    "APP_CONFIG=/mnt/xwing/config",
    "TZ=Asia/Kolkata",
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

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.port", 5050,
    ))}"

  memory                = 256
  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  # Running as lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  links = ["transmission"]
}

# resource "docker_container" "airsonic" {
#   name  = "airsonic"
#   image = "${docker_image.airsonic.latest}"

#   restart               = "unless-stopped"
#   destroy_grace_seconds = 30
#   must_run              = true
#   memory                = 800

#   volumes {
#     host_path      = "/mnt/xwing/config/airsonic/data"
#     container_path = "/config"
#   }

#   volumes {
#     host_path      = "/mnt/xwing/media/Music"
#     container_path = "/music"
#   }

#   volumes {
#     host_path      = "/mnt/xwing/config/airsonic/playlists"
#     container_path = "/playlists"
#   }

#   volumes {
#     host_path      = "/mnt/xwing/config/airsonic/podcasts"
#     container_path = "/podcasts"
#   }

#   labels {
#     "traefik.enable"                  = "true"
#     "traefik.port"                    = "4040"
#     "traefik.frontend.rule"           = "Host:airsonic.in.${var.domain},airsonic.${var.domain}"
#     "traefik.frontend.passHostHeader" = "true"
#   }

#   # lounge:tatooine
#   env = [
#     "PUID=1004",
#     "PGID=1003",
#     "TZ=Asia/Kolkata",
#     "CONTEXT_PATH=https://airsonic.bb8.fun",
#   ]
# }

resource "docker_container" "headerdebug" {
  name  = "headerdebug"
  image = "${docker_image.headerdebug.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true

  memory = 16

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.rule", "Host:debug.in.${var.domain},debug.${var.domain}",
      "traefik.port", 8080,
      "traefik.enable", "true",
    ))}"
}

resource "docker_container" "sickrage" {
  name  = "sickrage"
  image = "${docker_image.sickrage.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  memory = 512

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

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.passHostHeader", "false",
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.port", 8081,
    ))}"

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  links = [
    "transmission",
  ]
}

resource "docker_container" "headphones" {
  name  = "headphones"
  image = "${docker_image.headphones.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
  memory                = 128

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

  upload {
    content = "${file("${path.module}/conf/headphones.ini")}"
    file    = "/config/config.ini"
  }

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.port", 8181,
    ))}"

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

resource "docker_container" "ubooquity" {
  name  = "ubooquity"
  image = "${docker_image.ubooquity.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/ubooquity"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/EBooks"
    container_path = "/books"
  }

  volumes {
    host_path      = "/mnt/xwing/media/EBooks"
    container_path = "/files"
  }

  volumes {
    host_path      = "/mnt/xwing/media/EBooks/Comics"
    container_path = "/comics"
  }

  labels {
    "traefik.enable" = "true"

    "traefik.admin.port"                = 2203
    "traefik.admin.frontend.rule"       = "Host:library.${var.domain}"
    "traefik.admin.frontend.auth.basic" = "${var.basic_auth}"

    "traefik.read.port"          = 2202
    "traefik.read.frontend.rule" = "Host:read.${var.domain}"

    "traefik.read.frontend.headers.SSLTemporaryRedirect"  = "true"
    "traefik.read.frontend.headers.STSSeconds"            = "2592000"
    "traefik.read.frontend.headers.STSIncludeSubdomains"  = "false"
    "traefik.read.frontend.headers.contentTypeNosniff"    = "true"
    "traefik.read.frontend.headers.browserXSSFilter"      = "true"
    "traefik.read.frontend.headers.customResponseHeaders" = "${var.xpoweredby}"
    "traefik.frontend.headers.customFrameOptionsValue"    = "${var.xfo_allow}"
  }

  upload {
    content = "${file("${path.module}/conf/ubooquity.json")}"
    file    = "/config/preferences.json"
  }

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "MAXMEM=800",
  ]
}

resource "docker_container" "wiki" {
  name  = "wiki"
  image = "${docker_image.wikijs.latest}"

  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true
  memory                = 300

  upload {
    content = "${file("${path.module}/conf/wiki.yml")}"
    file    = "/var/wiki/config.yml"
  }

  volumes {
    host_path      = "/mnt/xwing/logs/wiki"
    container_path = "/logs"
  }

  volumes {
    host_path      = "/mnt/xwing/data/wiki/repo"
    container_path = "/repo"
  }

  volumes {
    host_path      = "/mnt/xwing/data/wiki/data"
    container_path = "/data"
  }

  upload {
    content = "${file("${path.module}/conf/humans.txt")}"
    file    = "/var/wiki/assets/humans.txt"
  }

  // The last header is a workaround for double header traefik bug
  // This might be actually breaking iframe till the 1.5 Final release.

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.frontend.rule", "Host:wiki.${var.domain}",
      "traefik.frontend.passHostHeader", "true",
      "traefik.port", 9999,
      "traefik.frontend.headers.customResponseHeaders", "${var.xpoweredby}||Referrer-Policy:${var.refpolicy}||X-Frame-Options:${var.xfo_allow}",
    ))}"
  links = ["mongorocks"]
  env = [
    "WIKI_ADMIN_EMAIL=me@captnemo.in",
    "SESSION_SECRET=${var.wiki_session_secret}",
  ]
}

resource "docker_container" "muximux" {
  name   = "muximux"
  image  = "${docker_image.muximux.latest}"
  memory = 64

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/mnt/xwing/config/muximux"
    container_path = "/config"
  }

  labels = "${merge(
    local.traefik_common_labels,
    map(
      "traefik.port", 80,
      "traefik.frontend.headers.frameDeny", "true",
      "traefik.frontend.passHostHeader", "false",
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.frontend.rule", "Host:home.in.${var.domain},home.${var.domain}",
    ))}"

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]
}

resource "docker_container" "cadvisor" {
  name   = "cadvisor"
  image  = "${docker_image.cadvisor.latest}"
  memory = 512

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true

  volumes {
    host_path      = "/"
    container_path = "/rootfs"
    read_only      = true
  }

  volumes {
    host_path      = "/sys"
    container_path = "/sys"
    read_only      = true
  }

  volumes {
    host_path      = "/var/lib/docker"
    container_path = "/var/lib/docker"
    read_only      = true
  }

  volumes {
    host_path      = "/dev/disk"
    container_path = "/dev/disk"
    read_only      = true
  }

  volumes {
    host_path      = "/var/run"
    container_path = "/var/run"
  }

  labels = "${merge(
    local.traefik_common_labels,
    map(

      "traefik.frontend.passHostHeader", "true",
      "traefik.frontend.auth.basic", "${var.basic_auth}",
      "traefik.port", 8080,
    ))}"
}

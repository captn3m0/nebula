resource "docker_container" "airsonic" {
  name                  = "airsonic"
  image                 = "${docker_image.airsonic.latest}"
  restart               = "unless-stopped"
  destroy_grace_seconds = 30
  must_run              = true

  # Unfortunately, the --device flag is not yet supported
  # in docker/terraform:
  # https://github.com/terraform-providers/terraform-provider-docker/issues/30

  upload {
    content = "${data.template_file.airsonic-properties-file.rendered}"
    file    = "/usr/lib/jvm/java-1.8-openjdk/jre/lib/airsonic.properties"
  }

  # This lets the Jukebox use ALSA
  upload {
    content = "${file("${path.module}/conf/airsonic.sound.properties")}"
    file    = "/usr/lib/jvm/java-1.8-openjdk/jre/lib/sound.properties"
  }

  volumes {
    host_path      = "/mnt/xwing/config/airsonic/data"
    container_path = "/config"
  }

  volumes {
    host_path      = "/mnt/xwing/media/Music"
    container_path = "/music"
  }

  volumes {
    host_path      = "/mnt/xwing/config/airsonic/playlists"
    container_path = "/playlists"
  }

  volumes {
    host_path      = "/mnt/xwing/config/airsonic/podcasts"
    container_path = "/podcasts"
  }

  labels {
    "traefik.enable"                  = "true"
    "traefik.port"                    = "4040"
    "traefik.frontend.rule"           = "Host:airsonic.in.${var.domain},airsonic.${var.domain}"
    "traefik.frontend.passHostHeader" = "true"
  }

  # lounge:tatooine
  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
  ]

  links = ["${var.links-mariadb}"]
}

resource "docker_image" "airsonic" {
  name          = "${data.docker_registry_image.airsonic.name}"
  pull_triggers = ["${data.docker_registry_image.airsonic.sha256_digest}"]
}

data "docker_registry_image" "airsonic" {
  name = "linuxserver/airsonic:latest"
}

data "template_file" "airsonic-properties-file" {
  template = "${file("${path.module}/conf/airsonic.properties.tpl")}"

  vars {
    smtp-password = "${var.airsonic-smtp-password}"
    db-password   = "${var.airsonic-db-password}"
  }
}

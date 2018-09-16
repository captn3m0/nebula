module "airsonic" {
  source = "../modules/container"
  image  = "linuxserver/airsonic:latest"
  name   = "airsonic"

  resource {
    memory = "256"
  }

  web {
    port   = 4040
    host   = "airsonic.bb8.fun"
    expose = true
  }

  user = "lounge:audio"

  env = [
    "PUID=1004",
    "PGID=1003",
    "TZ=Asia/Kolkata",
    "JAVA_OPTS=-Xmx512m -Dserver.use-forward-headers=true -Dserver.context-path=/",
  ]

  uploads = [
    {
      file    = "/usr/lib/jvm/java-1.8-openjdk/jre/lib/airsonic.properties"
      content = "${data.template_file.airsonic-properties-file.rendered}"
    },
    {
      file    = "/usr/lib/jvm/java-1.8-openjdk/jre/lib/sound.properties"
      content = "${file("${path.module}/conf/airsonic.sound.properties")}"
    },
  ]

  volumes = [
    {
      host_path      = "/mnt/xwing/config/airsonic2"
      container_path = "/config"
    },
    {
      host_path      = "/mnt/xwing/media/Music"
      container_path = "/music"
    },
    {
      host_path      = "/mnt/xwing/config/airsonic/playlists"
      container_path = "/playlists"
    },
    {
      host_path      = "/mnt/xwing/config/airsonic/podcasts"
      container_path = "/podcasts"
    },
  ]
}

data "template_file" "airsonic-properties-file" {
  template = "${file("${path.module}/conf/airsonic.properties.tpl")}"

  vars {
    smtp-password = "${var.airsonic-smtp-password}"

    # db-password   = "${var.airsonic-db-password}"
  }
}

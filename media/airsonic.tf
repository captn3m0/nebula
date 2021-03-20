# module "airsonic" {
#   source = "../modules/container"
#   image  = "linuxserver/airsonic:latest"
#   name   = "airsonic"
#   resource {
#     memory      = "1024"
#     memory_swap = "1024"
#   }
#   web {
#     port   = 4040
#     host   = "airsonic.bb8.fun"
#     expose = true
#   }
#   networks = "${list(docker_network.media.id, data.docker_network.bridge.id)}"
#   env = [
#     "PUID=1004",
#     "PGID=1003",
#     "TZ=Asia/Kolkata",
#     "JAVA_OPTS=-Xmx512m -Dserver.use-forward-headers=true -Dserver.context-path=/",
#   ]
#   devices = [{
#     host_path      = "/dev/snd"
#     container_path = "/dev/snd"
#   }]
#   # files = [
#   #   "/usr/lib/jvm/java-1.8-openjdk/jre/lib/airsonic.properties",
#   #   "/usr/lib/jvm/java-1.8-openjdk/jre/lib/sound.properties",
#   # ]
#   # contents = [
#   #   "${data.template_file.airsonic-properties-file.rendered}",
#   #   "${file("${path.module}/conf/airsonic.sound.properties")}",
#   # ]
#   volumes = [
#     {
#       host_path      = "/mnt/xwing/config/airsonic2"
#       container_path = "/config"
#     },
#     {
#       host_path      = "/mnt/xwing/media/Music"
#       container_path = "/music"
#     },
#     {
#       host_path      = "/mnt/xwing/config/airsonic/playlists"
#       container_path = "/playlists"
#     },
#     {
#       host_path      = "/mnt/xwing/config/airsonic/podcasts"
#       container_path = "/podcasts"
#     },
#     {
#       host_path      = "/mnt/xwing/config/airsonic/jre"
#       container_path = "/usr/lib/jvm/java-1.8-openjdk/jre/lib/"
#     },
#   ]
# }
# data "template_file" "airsonic-properties-file" {
#   template = "${file("${path.module}/conf/airsonic.properties.tpl")}"
#   vars {
#     smtp-password = "${var.airsonic-smtp-password}"
#     # db-password   = "${var.airsonic-db-password}"
#   }
# }

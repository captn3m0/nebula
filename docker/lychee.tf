# resource "docker_container" "lychee" {
#   name  = "lychee"
#   image = "${docker_image.lychee.image_id}"
#   restart               = "unless-stopped"
#   destroy_grace_seconds = 10
#   must_run              = true
#   volumes {
#     host_path      = "/mnt/xwing/config/lychee"
#     container_path = "/config"
#   }
#   volumes {
#     host_path      = "/mnt/xwing/data/lychee"
#     container_path = "/pictures"
#   }
#   upload {
#     content = "${file("${path.module}/conf/lychee.php.ini")}"
#     file    = "/config/lychee/user.ini"
#   }
#   labels = "${merge(
#     local.traefik_common_labels,
#     map(
#       "traefik.port", 80,
#       "traefik.frontend.rule", "Host:pics.${var.domain}",
#   ))}"
#   env = [
#     "PUID=986",
#     "PGID=984",
#   ]
#   # links = ["${var.links-mariadb}"]
# }

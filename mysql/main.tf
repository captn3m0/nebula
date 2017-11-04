# This is pending on https://github.com/hashicorp/go-version/pull/34
# provider "mysql" {
#   endpoint = "docker.captnemo.in:3306"
#   username = "root"
#   password = ""
# }
# Create a Database
# resource "mysql_database" "kodi" {
#   name = "kodi"
#   lifecycle {
#     prevent_destroy = true
#   }
# }
# resource "mysql_user" "kodi" {
#   user     = "kodi"
#   host     = "127.0.0.1"
#   password = ""
# }
# resource "mysql_grant" "kodi" {
#   user       = "${mysql_user.kodi.user}"
#   host       = "${mysql_user.kodi.host}"
#   database   = "kodi"
#   privileges = ["SUPER"]
# }


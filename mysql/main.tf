# This is pending on https://github.com/hashicorp/go-version/pull/34
provider "mysql" {
  endpoint = "docker.in.captnemo.in:3306"
  username = "root"
  password = "${var.mysql_root_password}"
}

# Create a Database
resource "mysql_database" "kodi" {
  name = "kodi"
  lifecycle {
    prevent_destroy = true
  }
}

resource "mysql_user" "kodi" {
  user     = "kodi"
  host     = "127.0.0.1"
  plaintext_password = "testing"
}
resource "mysql_grant" "kodi" {
  user       = "${mysql_user.kodi.user}"
  host       = "${mysql_user.kodi.host}"
  database   = "kodi"
  privileges = ["SUPER"]
}


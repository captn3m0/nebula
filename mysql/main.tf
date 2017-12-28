# # This is pending on https://github.com/hashicorp/go-version/pull/34

# Create a Database
resource "mysql_database" "kodi" {
  name = "kodi"
  lifecycle {
    prevent_destroy = true
  }
}

resource "mysql_user" "kodi" {
  user     = "kodi"
  plaintext_password = "testing"
}

resource "mysql_grant" "kodi" {
  user       = "${mysql_user.kodi.user}"
  host       = "${mysql_user.kodi.host}"
  database   = "kodi"
  privileges = ["SUPER"]
}

resource "mysql_user" "lychee" {
  user     = "lychee"
  plaintext_password = "testing"
}

resource "mysql_grant" "lychee" {
  user       = "${mysql_user.lychee.user}"
  host       = "${mysql_user.lychee.host}"
  database   = "lychee"
  privileges = ["SUPER"]
}


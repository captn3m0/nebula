# # This is pending on https://github.com/hashicorp/go-version/pull/34

# Create a Database
resource "mysql_database" "lychee" {
  name = "lychee"
}

resource "mysql_user" "lychee" {
  user               = "lychee"
  host               = "%"
  plaintext_password = "${var.mysql_lychee_password}"
}

resource "mysql_grant" "lychee" {
  user       = "${mysql_user.lychee.user}"
  host       = "${mysql_user.lychee.host}"
  database   = "${mysql_database.lychee.name}"
  privileges = ["ALL"]
}

# Create a Database
resource "mysql_database" "airsonic" {
  name = "airsonic"
}

resource "mysql_user" "airsonic" {
  user               = "airsonic"
  host               = "%"
  plaintext_password = "${var.mysql_airsonic_password}"
}

resource "mysql_grant" "airsonic" {
  user       = "${mysql_user.airsonic.user}"
  host       = "${mysql_user.airsonic.host}"
  database   = "${mysql_database.airsonic.name}"
  privileges = ["ALL"]
}

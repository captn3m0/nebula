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

resource "mysql_database" "monica" {
  name = "monica"
}

resource "mysql_user" "monica" {
  user               = "monica"
  host               = "%"
  plaintext_password = "${var.db-password}"
}

resource "mysql_grant" "monica" {
  user       = "${mysql_user.monica.user}"
  host       = "${mysql_user.monica.host}"
  database   = "${mysql_database.monica.name}"
  privileges = ["ALL"]
}

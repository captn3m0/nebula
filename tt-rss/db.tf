resource "mysql_database" "ttrss" {
  name = "ttrss"
}

resource "mysql_user" "ttrss" {
  user               = "ttrss"
  host               = "%"
  plaintext_password = "${var.mysql_password}"
}

resource "mysql_grant" "ttrss" {
  user       = "${mysql_user.ttrss.user}"
  host       = "${mysql_user.ttrss.host}"
  database   = "${mysql_database.ttrss.name}"
  privileges = ["ALL"]
}

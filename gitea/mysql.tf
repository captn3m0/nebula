resource "mysql_database" "gitea" {
  name = "gitea"
}

resource "mysql_user" "gitea" {
  user               = "gitea"
  host               = "%"
  plaintext_password = "${var.mysql-password}"
}

resource "mysql_grant" "gitea" {
  user       = "${mysql_user.gitea.user}"
  host       = "${mysql_user.gitea.host}"
  database   = "${mysql_database.gitea.name}"
  privileges = ["ALL"]
}

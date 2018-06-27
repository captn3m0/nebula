resource "postgresql_database" "ttrss" {
  name  = "ttrss"
  owner = "ttrss"
}

resource "postgresql_role" "ttrss" {
  name     = "ttrss"
  login    = true
  password = "${var.mysql_password}"
}

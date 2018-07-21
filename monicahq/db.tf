resource "postgresql_database" "monica" {
  name  = "monica"
  owner = "monica"
}

resource "postgresql_role" "monica" {
  name     = "monica"
  login    = true
  password = "${var.db-password}"
}

resource "postgresql_database" "miniflux" {
  name  = "miniflux"
  owner = "miniflux"
}

resource "postgresql_role" "miniflux" {
  name     = "miniflux"
  login    = true
  password = "${var.db-password}"
}

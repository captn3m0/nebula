resource "postgresql_database" "db" {
  name  = var.name
  owner = var.name
}

resource "postgresql_role" "role" {
  name     = var.name
  login    = true
  password = var.password
}


module "database" {
  source   = "../postgres"
  name     = "${var.db_name}"
  password = "${random_string.password.result}"
}

module "database_test" {
  source   = "../postgres"
  name     = "${var.db_name_test}"
  password = "${random_string.password_test.result}"
}

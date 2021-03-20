variable "root_db_password" {
}

variable "db_password" {
}

locals {
  username    = "wordpress"
  database    = "wordpress"
  db_hostname = "kaarana.db"
}


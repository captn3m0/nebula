# kaarana related stuff

# module "kaarana" {
#   source = "./kaarana"

#   root_db_password = data.pass_password.kaarana-root-db-password.password
#   db_password      = data.pass_password.kaarana-db-password.password

#   providers = {
#     docker = docker.sydney
#   }
# }

data "pass_password" "kaarana-root-db-password" {
  path = "KAARANA_DB_ROOT_PASSWORD"
}

data "pass_password" "kaarana-db-password" {
  path = "KAARANA_DB_PASSWORD"
}


module "stringer-db" {
  source   = "modules/postgres"
  name     = "stringer"
  password = "${data.pass_password.stringer-db-password.password}"
}

# module "stringer-container" {
#   name   = "stringer"
#   source = "modules/container"
#   image  = "mdswanson/stringer"


#   resource {
#     memory      = 256
#     memory_swap = 256
#   }


#   web {
#     expose = true
#     port   = 8080
#     host   = "stringer.bb8.fun"
#   }


#   networks = "${list(
#     data.docker_network.bridge.id,
#     module.docker.traefik-network-id,
#     module.db.postgres-network-id
#   )}"


#   env = [
#     # "DATABASE_URL=postgres://stringer:${data.pass_password.stringer-db-password.password}@postgres:5432/stringer",
#     "DATABASE_URL=sqlite3:':memory:'",


#     "SECRET_TOKEN=${data.pass_password.stringer-secret-token.password}",
#     "RACK_ENV=development",
#   ]
# }


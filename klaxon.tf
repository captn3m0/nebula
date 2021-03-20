module "klaxon-db" {
  source   = "./modules/postgres"
  name     = "klaxon"
  password = data.pass_password.klaxon-db-password.password
}

module "klaxon" {
  name   = "klaxon"
  source = "./modules/container"

  web = {
    expose = true
    port   = "3000"
    host   = "klaxon.${var.root-domain}"
  }

  resource = {
    memory      = 1024
    memory_swap = 1024
  }

  env = [
    "DATABASE_URL=postgres://klaxon:${data.pass_password.klaxon-db-password.password}@postgres/klaxon",
    "ADMIN_EMAILS=klaxon.admin@captnemo.in",
    "RAILS_ENV=production",
    "SECRET_KEY_BASE=${data.pass_password.klaxon-secret-key.password}",
    "SENDGRID_USERNAME=apikey",
    "SENDGRID_PASSWORD=${data.pass_password.klaxon-sendgrid-password.password}",
    "KLAXON_FORCE_SSL=false",
    "KLAXON_COMPILE_ASSETS=true",
    "ADMIN_EMAILS=klaxon@captnemo.in",
    "MAILER_FROM_ADDRESS=klaxon@sendgrid.captnemo.in",
  ]
  restart = "always"

  image = "themarshallproject/klaxon"

  networks_advanced = [
    {
      name = "traefik"
    },
    {
      name = "postgres"
    },
    {
      name = "external"
    },
  ]
}


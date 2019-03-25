module "monicahq-container" {
  name   = "monica"
  source = "modules/container"
  image  = "monicahq/monicahq:latest"

  web {
    expose = true
    host   = "monica.${var.root-domain}"
  }

  networks = "${list(module.docker.traefik-network-id,module.db.postgres-network-id)}"

  env = [
    "APP_ENV=production",
    "APP_DEBUG=false",
    "APP_KEY=${data.pass_password.monica-app-key.password}",
    "HASH_SALT=${data.pass_password.monica-hash-salt.password}",
    "HASH_LENGTH=18",
    "APP_URL=https://monica.${var.root-domain}",
    "DB_CONNECTION=pgsql",
    "DB_HOST=postgres",
    "DB_DATABASE=monica",
    "DB_PORT=5432",
    "DB_USERNAME=monica",
    "DB_PASSWORD=${data.pass_password.monica-db-password.password}",
    "DB_PREFIX=",
    "MAIL_DRIVER=smtp",
    "MAIL_HOST=smtp.mailgun.org",
    "MAIL_PORT=587",
    "MAIL_USERNAME=monica@captnemo.in",
    "MAIL_PASSWORD=${data.pass_password.monica-smtp-password.password}",
    "MAIL_ENCRYPTION=tls",
    "MAIL_FROM_ADDRESS=monica@captnemo.in",
    "MAIL_FROM_NAME=Nemo",
    "APP_EMAIL_NEW_USERS_NOTIFICATION=monica@captnemo.in",
    "APP_DEFAULT_TIMEZONE=Asia/Kolkata",
    "APP_DEFAULT_LOCALE=en",

    # Ability to disable signups on your instance.
    # Can be true or false. Default to false.
    "APP_DISABLE_SIGNUP=false",

    "LOG_CHANNEL=single",
    "SENTRY_SUPPORT=false",
    "CHECK_VERSION=true",
    "REQUIRES_SUBSCRIPTION=false",

    # cache redis is not yet documented
    "CACHE_DRIVER=database",

    "SESSION_DRIVER=file",
    "SESSION_LIFETIME=120",
    "QUEUE_DRIVER=sync",
    "DEFAULT_FILESYSTEM=public",
    "2FA_ENABLED=true",
    "ALLOW_STATISTICS_THROUGH_PUBLIC_API_ACCESS=false",
    "APP_TRUSTED_PROXIES=*",
  ]
}

module "monicahq-db" {
  source   = "modules/postgres"
  name     = "monica"
  password = "${data.pass_password.monica-db-password.password}"
}

data "docker_registry_image" "monica" {
  name = "monicahq/monicahq:latest"
}

resource "docker_image" "monica" {
  name          = "${data.docker_registry_image.monica.name}"
  pull_triggers = ["${data.docker_registry_image.monica.sha256_digest}"]
}

resource "docker_container" "monica" {
  name  = "monica"
  image = "${docker_image.monica.latest}"

  labels = "${merge(
    var.traefik-labels, map(
      "traefik.port", 80,
      "traefik.frontend.rule","Host:${var.domain}"
  ))}"

  networks = ["${var.traefik-network-id}", "${var.postgres-network-id}"]

  env = [
    "APP_ENV=production",
    "APP_DEBUG=false",
    "APP_KEY=${var.app-key}",
    "HASH_SALT=${var.hash-salt}",
    "HASH_LENGTH=18",
    "APP_URL=https://${var.domain}",
    "DB_CONNECTION=pgsql",
    "DB_HOST=postgres",
    "DB_DATABASE=monica",
    "DB_PORT=5432",
    "DB_USERNAME=monica",
    "DB_PASSWORD=${var.db-password}",
    "DB_PREFIX=",
    "MAIL_DRIVER=smtp",
    "MAIL_HOST=smtp.mailgun.org",
    "MAIL_PORT=587",
    "MAIL_USERNAME=monica@captnemo.in",
    "MAIL_PASSWORD=${var.smtp-password}",
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

  restart               = "unless-stopped"
  destroy_grace_seconds = 10
  must_run              = true
}

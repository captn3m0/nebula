locals {
  version = "4.1.4"
  env = [
    "LOCAL_DOMAIN=tatooine.club",
    "REDIS_HOST=mastodon-redis",
    "REDIS_PORT=6379",
    "DB_HOST=postgres",
    "DB_USER=mastodon",
    "DB_NAME=mastodon",
    "DB_PASS=${var.db-password}",
    "DB_PORT=5432",
    "ES_ENABLED=false",
    "SECRET_KEY_BASE=${var.secret-key-base}",
    "OTP_SECRET=${var.otp-secret}",
    "VAPID_PRIVATE_KEY=${var.vapid-private-key}",
    "VAPID_PUBLIC_KEY=${var.vapid-public-key}",
    "SMTP_SERVER=smtp.eu.mailgun.org",
    "SMTP_PORT=587",
    "SMTP_LOGIN=mastodon@mail.tatooine.club",
    "SMTP_PASSWORD=${var.smtp-password}",
    "SMTP_FROM_ADDRESS=mastodon@mail.tatooine.club",
  ]
}

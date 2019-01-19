resource "random_string" "password" {
  length  = 16
  special = false
}

resource "random_string" "password_test" {
  length  = 16
  special = false
}

resource "random_string" "minio_access_key" {
  length  = 20
  lower   = false
  special = false
}

resource "random_string" "minio_secret_key" {
  length  = 20
  lower   = false
  special = false
}

locals {
  minio_secret_key = "${random_string.minio_secret_key.result}"
  minio_access_key = "${random_string.minio_access_key.result}"

  environment = [
    "DATABASE_URL=postgres://${var.db_username}:${random_string.password.result}@${var.db_host}:${var.db_port}/${var.db_name}?ssl_mode=disable",
    "DATABASE_URL_TEST=postgres://${var.db_username}:${random_string.password_test.result}@${var.db_host}:${var.db_port}/${var.db_name_test}?ssl_mode=disable",
    "SECRET_KEY=${var.secret_key}",
    "PORT=3000",
    "REDIS_URL=redis://${var.cache_host}:${var.cache_port}",
    "URL=https://${var.hostname}",
    "DEPLOYMENT=self",
    "ENABLE_UPDATES=false",
    "SUBDOMAINS_ENABLED=false",

    # Third party signin credentials (at least one is required)
    "SLACK_KEY=${var.slack_key}",

    "SLACK_VERIFICATION_TOKEN=${var.slack_verification_token}",
    "SLACK_APP_ID=${var.slack_app_id}",
    "SLACK_SECRET=${var.slack_secret}",
    "GOOGLE_CLIENT_ID=",
    "GOOGLE_CLIENT_SECRET=",

    # Comma separated list of domains to be allowed (optional)
    # If not set, all Google apps domains are allowed by default
    "GOOGLE_ALLOWED_DOMAINS=",

    # Emails configuration (optional)
    "SMTP_HOST=smtp.mailgun.org",

    "SMTP_PORT=465",
    "SMTP_USERNAME=${var.smtp_username}",
    "SMTP_PASSWORD=${var.smtp_password}",
    "SMTP_FROM_EMAIL=${var.smtp_email}",
    "SMTP_REPLY_EMAIL=${var.reply_email}",

    # AWS credentials (optional in dev)
    "AWS_ACCESS_KEY_ID=${local.minio_access_key}",

    "AWS_SECRET_ACCESS_KEY=${local.minio_secret_key}",
    "AWS_S3_UPLOAD_BUCKET_URL=http://outline-s3:9000",
    "AWS_S3_UPLOAD_BUCKET_NAME=outline",
    "AWS_S3_UPLOAD_MAX_SIZE=26214400",
  ]

  # Used for showing new releases
  # If given, can go around rate limits
  # "GITHUB_ACCESS_TOKEN=",

  # Third party credentials (optional)

  # "GOOGLE_ANALYTICS_ID=",
  # "BUGSNAG_KEY=",
  # "DEBUG=sql,cache,presenters,events",
}

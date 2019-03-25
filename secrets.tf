locals {
  pass = "/home/nemo/.password-store/Nebula"
}

data "pass_password" "airsonic-smtp-password" {
  path = "${local.pass}/AIRSONIC_SMTP_PASSWORD"
}

data "pass_password" "digitalocean-token" {
  path = "${local.pass}/DO_TOKEN"
}

data "pass_password" "gitea-internal-token" {
  path = "${local.pass}/GITEA_INTERNAL_TOKEN"
}

data "pass_password" "gitea-lfs-jwt-secret" {
  path = "${local.pass}/GITEA_LFS_JWT_SECRET"
}

data "pass_password" "gitea-secret-key" {
  path = "${local.pass}/GITEA_SECRET_KEY"
}

data "pass_password" "gf-security-admin-password" {
  path = "${local.pass}/GRAFANA_ADMIN_PASSWORD"
}

data "pass_password" "gitea-smtp-password" {
  path = "${local.pass}/GITEA_SMTP_PASSWORD"
}

data "pass_password" "miniflux-db-password" {
  path = "${local.pass}/MINIFLUX_DB_PASSWORD"
}

data "pass_password" "cloudflare_key" {
  path = "${local.pass}/CLOUDFLARE_KEY"
}

// /me gives up on upper casing here and scripts it instead

data "pass_password" "monica-app-key" {
  path = "${local.pass}/monica-app-key"
}

data "pass_password" "monica-db-password" {
  path = "${local.pass}/monica-db-password"
}

data "pass_password" "monica-hash-salt" {
  path = "${local.pass}/monica-hash-salt"
}

data "pass_password" "monica-smtp-password" {
  path = "${local.pass}/monica-smtp-password"
}

data "pass_password" "nextcloud-db-password" {
  path = "${local.pass}/nextcloud-db-password"
}

data "pass_password" "opml-github-client-id" {
  path = "${local.pass}/opml-github-client-id"
}

data "pass_password" "opml-github-client-secret" {
  path = "${local.pass}/opml-github-client-secret"
}

data "pass_password" "outline_secret_key" {
  path = "${local.pass}/outline-secret-key"
}

data "pass_password" "outline_slack_app_id" {
  path = "${local.pass}/outline-slack-app-id"
}

data "pass_password" "outline_slack_key" {
  path = "${local.pass}/outline-slack-key"
}

data "pass_password" "outline_slack_secret" {
  path = "${local.pass}/outline-slack-secret"
}

data "pass_password" "outline_slack_verification_token" {
  path = "${local.pass}/outline-slack-verification-token"
}

data "pass_password" "outline_smtp_password" {
  path = "${local.pass}/outline-smtp-password"
}

data "pass_password" "pihole_password" {
  path = "${local.pass}/pihole-password"
}

data "pass_password" "syncserver_secret" {
  path = "${local.pass}/syncserver-secret"
}

data "pass_password" "timemachine-password-1" {
  path = "${local.pass}/timemachine-password-1"
}

data "pass_password" "timemachine-password-2" {
  path = "${local.pass}/timemachine-password-2"
}

data "pass_password" "postgres-root-password" {
  path = "${local.pass}/postgres-root-password"
}

data "pass_password" "znc_pass" {
  path = "${local.pass}/znc-pass"
}

data "pass_password" "znc_user" {
  path = "${local.pass}/znc-user"
}

data "pass_password" "wiki_session_secret" {
  path = "${local.pass}/wiki_session_secret"
}

data "pass_password" "web_username" {
  path = "${local.pass}/web_username"
}

data "pass_password" "web_password" {
  path = "${local.pass}/web_password"
}

data "pass_password" "airsonic-smtp-password" {
  path = "AIRSONIC_SMTP_PASSWORD"
}

data "pass_password" "digitalocean-token" {
  path = "DO_TOKEN"
}

data "pass_password" "gitea-internal-token" {
  path = "GITEA_INTERNAL_TOKEN"
}

data "pass_password" "gitea-lfs-jwt-secret" {
  path = "GITEA_LFS_JWT_SECRET"
}

data "pass_password" "gitea-secret-key" {
  path = "GITEA_SECRET_KEY"
}

data "pass_password" "gitea-oauth2-jwt-secret" {
  path = "GITEA_OAUTH2_JWT_SECRET"
}

data "pass_password" "gf-security-admin-password" {
  path = "GRAFANA_ADMIN_PASSWORD"
}

data "pass_password" "gitea-smtp-password" {
  path = "GITEA_SMTP_PASSWORD"
}

data "pass_password" "miniflux-db-password" {
  path = "MINIFLUX_DB_PASSWORD"
}

data "pass_password" "cloudflare_key" {
  path = "CLOUDFLARE_KEY"
}

// /me gives up on upper casing here and scripts it instead

data "pass_password" "monica-app-key" {
  path = "monica-app-key"
}

data "pass_password" "monica-db-password" {
  path = "monica-db-password"
}

data "pass_password" "monica-hash-salt" {
  path = "monica-hash-salt"
}

data "pass_password" "monica-smtp-password" {
  path = "monica-smtp-password"
}

data "pass_password" "nextcloud-db-password" {
  path = "nextcloud-db-password"
}

data "pass_password" "opml-github-client-id" {
  path = "opml-github-client-id"
}

data "pass_password" "opml-github-client-secret" {
  path = "opml-github-client-secret"
}

data "pass_password" "outline_secret_key" {
  path = "outline-secret-key"
}

data "pass_password" "outline_slack_app_id" {
  path = "outline-slack-app-id"
}

data "pass_password" "outline_slack_key" {
  path = "outline-slack-key"
}

data "pass_password" "outline_slack_secret" {
  path = "outline-slack-secret"
}

data "pass_password" "outline_slack_verification_token" {
  path = "outline-slack-verification-token"
}

data "pass_password" "outline_smtp_password" {
  path = "outline-smtp-password"
}

data "pass_password" "pihole_password" {
  path = "pihole-password"
}

data "pass_password" "syncserver_secret" {
  path = "SYNCSERVER_SECRET"
}

data "pass_password" "timemachine-password-1" {
  path = "timemachine-password-1"
}

data "pass_password" "timemachine-password-2" {
  path = "timemachine-password-2"
}

data "pass_password" "postgres-root-password" {
  path = "postgres-root-password"
}

data "pass_password" "znc_pass" {
  path = "znc-pass"
}

data "pass_password" "znc_user" {
  path = "znc-user"
}

data "pass_password" "wiki_session_secret" {
  path = "wiki_session_secret"
}

data "pass_password" "web_username" {
  path = "web_username"
}

data "pass_password" "web_password" {
  path = "web_password"
}

data "pass_password" "stringer-db-password" {
  path = "stringer-db-password"
}

data "pass_password" "stringer-secret-token" {
  path = "stringer-secret-token"
}

data "pass_password" "wiki-db-password" {
  path = "wiki-db-password"
}

data "pass_password" "klaxon-db-password" {
  path = "klaxon-db-password"
}

data "pass_password" "klaxon-secret-key" {
  path = "klaxon-secret-key"
}

data "pass_password" "klaxon-sendgrid-password" {
  path = "klaxon-sendgrid-password"
}

data "pass_password" "navidrome-lastfm-api-key" {
  path = "navidrome-lastfm-api-key"
}

data "pass_password" "navidrome-lastfm-secret" {
  path = "navidrome-lastfm-secret"
}

data "pass_password" "navidrome-spotify-id" {
  path = "navidrome-spotify-id"
}

data "pass_password" "navidrome-spotify-secret" {
  path = "navidrome-spotify-secret"
}


data "pass_password" "airsonic-smtp-password" {
  path = "Nebula/AIRSONIC_SMTP_PASSWORD"
}

data "pass_password" "digitalocean-token" {
  path = "Nebula/DO_TOKEN"
}

data "pass_password" "gitea-internal-token" {
  path = "Nebula/GITEA_INTERNAL_TOKEN"
}

data "pass_password" "gitea-lfs-jwt-secret" {
  path = "Nebula/GITEA_LFS_JWT_SECRET"
}

data "pass_password" "gitea-secret-key" {
  path = "Nebula/GITEA_SECRET_KEY"
}

data "pass_password" "gitea-oauth2-jwt-secret" {
  path = "Nebula/GITEA_OAUTH2_JWT_SECRET"
}

data "pass_password" "gf-security-admin-password" {
  path = "Nebula/GRAFANA_ADMIN_PASSWORD"
}

data "pass_password" "gitea-smtp-password" {
  path = "Nebula/GITEA_SMTP_PASSWORD"
}

data "pass_password" "miniflux-db-password" {
  path = "Nebula/MINIFLUX_DB_PASSWORD"
}

data "pass_password" "firesync-db-password" {
  path = "Nebula/FIRESYNC_DB_PASSWORD"
}

data "pass_password" "cloudflare_key" {
  path = "Nebula/CLOUDFLARE_KEY"
}

// /me gives up on upper casing here and scripts it instead

data "pass_password" "monica-app-key" {
  path = "Nebula/monica-app-key"
}

data "pass_password" "monica-db-password" {
  path = "Nebula/monica-db-password"
}

data "pass_password" "monica-hash-salt" {
  path = "Nebula/monica-hash-salt"
}

data "pass_password" "monica-smtp-password" {
  path = "Nebula/monica-smtp-password"
}

data "pass_password" "nextcloud-db-password" {
  path = "Nebula/nextcloud-db-password"
}

data "pass_password" "opml-github-client-id" {
  path = "Nebula/opml-github-client-id"
}

data "pass_password" "opml-github-client-secret" {
  path = "Nebula/opml-github-client-secret"
}

data "pass_password" "outline_secret_key" {
  path = "Nebula/outline-secret-key"
}

data "pass_password" "outline_slack_app_id" {
  path = "Nebula/outline-slack-app-id"
}

data "pass_password" "outline_slack_key" {
  path = "Nebula/outline-slack-key"
}

data "pass_password" "outline_slack_secret" {
  path = "Nebula/outline-slack-secret"
}

data "pass_password" "outline_slack_verification_token" {
  path = "Nebula/outline-slack-verification-token"
}

data "pass_password" "outline_smtp_password" {
  path = "Nebula/outline-smtp-password"
}

data "pass_password" "pihole_password" {
  path = "Nebula/pihole_password"
}

data "pass_password" "syncserver_secret" {
  path = "Nebula/SYNCSERVER_SECRET"
}

data "pass_password" "timemachine-password-1" {
  path = "Nebula/timemachine-password-1"
}

data "pass_password" "timemachine-password-2" {
  path = "Nebula/timemachine-password-2"
}

data "pass_password" "postgres-root-password" {
  path = "Nebula/postgres-root-password"
}

data "pass_password" "znc_pass" {
  path = "Nebula/znc-pass"
}

data "pass_password" "znc_user" {
  path = "Nebula/znc-user"
}

data "pass_password" "wiki_session_secret" {
  path = "Nebula/wiki_session_secret"
}

data "pass_password" "web_username" {
  path = "Nebula/web_username"
}

data "pass_password" "web_password" {
  path = "Nebula/web_password"
}

data "pass_password" "stringer-db-password" {
  path = "Nebula/stringer-db-password"
}

data "pass_password" "stringer-secret-token" {
  path = "Nebula/stringer-secret-token"
}

data "pass_password" "wiki-db-password" {
  path = "Nebula/wiki-db-password"
}

data "pass_password" "klaxon-db-password" {
  path = "Nebula/klaxon-db-password"
}

data "pass_password" "klaxon-secret-key" {
  path = "Nebula/klaxon-secret-key"
}

data "pass_password" "klaxon-sendgrid-password" {
  path = "Nebula/klaxon-sendgrid-password"
}

data "pass_password" "navidrome-lastfm-api-key" {
  path = "Nebula/navidrome-lastfm-api-key"
}

data "pass_password" "navidrome-lastfm-secret" {
  path = "Nebula/navidrome-lastfm-secret"
}

data "pass_password" "navidrome-spotify-id" {
  path = "Nebula/navidrome-spotify-id"
}

data "pass_password" "navidrome-spotify-secret" {
  path = "Nebula/navidrome-spotify-secret"
}



data "pass_password" "mastodon-db-password" {
  path = "Nebula/MASTODON_DB_PASSWORD"
}

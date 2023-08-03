module "cloudflare" {
  source  = "./cloudflare"
  domain  = "bb8.fun"
  zone_id = lookup(data.cloudflare_zones.bb8.zones[0], "id")
  ips     = var.ips

  droplet_ip = module.digitalocean.droplet_ipv4
}

module "docker" {
  source              = "./docker"
  web_username        = data.pass_password.web_username.password
  web_password        = data.pass_password.web_password.password
  cloudflare_key      = data.pass_password.cloudflare_key.password
  cloudflare_email    = "bb8@captnemo.in"
  wiki_session_secret = data.pass_password.wiki_session_secret.password
  ips                 = var.ips
  domain              = "bb8.fun"
}

module "db" {
  source                 = "./db"
  postgres-root-password = data.pass_password.postgres-root-password.password
  ips                    = var.ips
}

module "timemachine" {
  source     = "./timemachine"
  ips        = var.ips
  username-1 = "vikalp"
  username-2 = "rishav"
  password-1 = data.pass_password.timemachine-password-1.password
  password-2 = data.pass_password.timemachine-password-2.password
}

module "gitea" {
  source            = "./gitea"
  domain            = "git.captnemo.in"
  traefik-labels    = var.traefik-common-labels
  ips               = var.ips
  secret-key        = data.pass_password.gitea-secret-key.password
  internal-token    = data.pass_password.gitea-internal-token.password
  smtp-password     = data.pass_password.gitea-smtp-password.password
  lfs-jwt-secret    = data.pass_password.gitea-lfs-jwt-secret.password
  oauth2-jwt-secret = data.pass_password.gitea-oauth2-jwt-secret.password

  //passed, but not used
  mysql-password = ""

  traefik-network-id = module.docker.traefik-network-id
}

module "opml" {
  source             = "./opml"
  domain             = "opml.bb8.fun"
  client-id          = data.pass_password.opml-github-client-id.password
  client-secret      = data.pass_password.opml-github-client-secret.password
  traefik-network-id = module.docker.traefik-network-id
}

module "radicale" {
  source = "./radicale"
  domain = "radicale.bb8.fun"
}

module "media" {
  source             = "./media"
  domain             = "bb8.fun"
  traefik-labels     = var.traefik-common-labels
  ips                = var.ips
  # ToDO: Change this to lookup
  traefik-network-id = "ffc1e366849e"
  lastfm_api_key     = data.pass_password.navidrome-lastfm-api-key.password
  lastfm_secret      = data.pass_password.navidrome-lastfm-secret.password
  spotify_id         = data.pass_password.navidrome-spotify-id.password
  spotify_secret     = data.pass_password.navidrome-spotify-secret.password
}

module "monitoring" {
  source                     = "./monitoring"
  gf-security-admin-password = data.pass_password.gf-security-admin-password.password
  domain                     = "bb8.fun"
  transmission               = module.media.names-transmission
  traefik-labels             = var.traefik-common-labels
  ips                        = var.ips
  links-traefik              = module.docker.names-traefik
  traefik-network-id         = module.docker.traefik-network-id
}

module "digitalocean" {
  source = "./digitalocean"
}

module "home-assistant" {
  source = "./home-assistant"
}

module "mastodon" {
  source = "./mastodon"
  db-password = data.pass_password.mastodon-db-password.password
  secret-key-base = data.pass_password.mastodon-secret-key-base.password
  otp-secret = data.pass_password.mastodon-otp-secret.password
  vapid-private-key = data.pass_password.mastodon-vapid-private-key.password
  vapid-public-key = data.pass_password.mastodon-vapid-public-key.password
  smtp-password = data.pass_password.mastodon-smtp-password.password
}

// Used to force access to ISP related resources
# module "tinyproxy" {
#   source = "./tinyproxy"
#   ips    = "${var.ips}"
# }

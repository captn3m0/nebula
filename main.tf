module "cloudflare" {
  source = "cloudflare"
  domain = "bb8.fun"
  ips    = "${var.ips}"
}

module "mysql" {
  source                  = "mysql"
  mysql_root_password     = "${var.mysql_root_password}"
  mysql_lychee_password   = "${var.mysql_lychee_password}"
  mysql_airsonic_password = "${var.mysql_airsonic_password}"
  mysql_kodi_password     = "${var.mysql_kodi_password}"
  lychee_ip               = "${module.docker.lychee-ip}"
}

module "docker" {
  source              = "docker"
  web_username        = "${var.web_username}"
  web_password        = "${var.web_password}"
  cloudflare_key      = "${var.cloudflare_key}"
  cloudflare_email    = "bb8@captnemo.in"
  wiki_session_secret = "${var.wiki_session_secret}"
  links-mariadb       = "${module.db.names-mariadb}"
  networks-mongorocks = "${module.db.networks-mongorocks}"
  ips                 = "${var.ips}"
  domain              = "bb8.fun"
}

module "db" {
  source              = "db"
  mysql_root_password = "${var.mysql_root_password}"
  ips                 = "${var.ips}"
}

module "timemachine" {
  source     = "timemachine"
  ips        = "${var.ips}"
  username-1 = "vikalp"
  password-1 = "${var.timemachine-password-1}"
  username-2 = "rishav"
  password-2 = "${var.timemachine-password-2}"
}

module "gitea" {
  source         = "gitea"
  domain         = "git.captnemo.in"
  traefik-labels = "${var.traefik-common-labels}"
  ips            = "${var.ips}"
  secret-key     = "${var.gitea-secret-key}"
  internal-token = "${var.gitea-internal-token}"
  smtp-password  = "${var.gitea-smtp-password}"
  lfs-jwt-secret = "${var.gitea-lfs-jwt-secret}"
  mysql-password = "${var.gitea-mysql-password}"
}

module "opml" {
  source         = "opml"
  domain         = "opml.bb8.fun"
  client-id      = "${var.opml-github-client-id}"
  client-secret  = "${var.opml-github-client-secret}"
  traefik-labels = "${var.traefik-common-labels}"
}

module "radicale" {
  source         = "radicale"
  domain         = "radicale.bb8.fun"
  traefik-labels = "${var.traefik-common-labels}"
}

module "tt-rss" {
  source         = "tt-rss"
  domain         = "rss.captnemo.in"
  mysql_password = "${var.mysql-ttrss-password}"
  links-db       = "${module.db.names-mariadb}"
  traefik-labels = "${var.traefik-common-labels}"
}

module "requestbin" {
  source         = "requestbin"
  domain         = "requestbin.bb8.fun"
  traefik-labels = "${var.traefik-common-labels}"
}

module "resilio" {
  source         = "resilio"
  domain         = "sync.bb8.fun"
  traefik-labels = "${var.traefik-common-labels}"
  ips            = "${var.ips}"
}

module "heimdall" {
  source         = "heimdall"
  domain         = "bb8.fun"
  traefik-labels = "${var.traefik-common-labels}"
  auth-header    = "${module.docker.auth-header}"
}

module "media" {
  source                 = "media"
  domain                 = "bb8.fun"
  links-mariadb          = "${module.db.names-mariadb}"
  traefik-labels         = "${var.traefik-common-labels}"
  airsonic-smtp-password = "${var.airsonic-smtp-password}"
  airsonic-db-password   = "${var.mysql_airsonic_password}"
  ips                    = "${var.ips}"
}

module "monitoring" {
  source                     = "monitoring"
  gf-security-admin-password = "${var.gf-security-admin-password}"
  domain                     = "bb8.fun"
  transmission               = "${module.media.names-transmission}"
  traefik-labels             = "${var.traefik-common-labels}"
  ips                        = "${var.ips}"
  links-traefik              = "${module.docker.names-traefik}"
}

module "digitalocean" {
  source = "digitalocean"
}

module "abstruse" {
  source         = "abstruse"
  domain         = "ci.bb8.fun"
  traefik-labels = "${var.traefik-common-labels}"
}

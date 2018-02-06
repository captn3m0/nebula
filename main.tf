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
  source               = "docker"
  web_username         = "${var.web_username}"
  web_password         = "${var.web_password}"
  mysql_root_password  = "${var.mysql_root_password}"
  cloudflare_key       = "${var.cloudflare_key}"
  cloudflare_email     = "bb8@captnemo.in"
  wiki_session_secret  = "${var.wiki_session_secret}"
  ips                  = "${var.ips}"
  domain               = "bb8.fun"
}

module "gitea" {
  source         = "gitea"
  domain         = "git.captnemo.in"
  traefik-labels = "${var.traefik-common-labels}"
  ips            = "${var.ips}"
  secret-key     = "${var.gitea-secret-key}"
  internal-token = "${var.gitea-internal-token}"
  smtp-password  = "${var.gitea-smtp-password}"
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
  links-db       = "${module.docker.names-mariadb}"
  traefik-labels = "${var.traefik-common-labels}"
}

module "media" {
  source             = "media"
  domain             = "bb8.fun"
  links-emby         = "${module.docker.names-emby}"
  links-transmission = "${module.docker.names-transmission}"
  traefik-labels     = "${var.traefik-common-labels}"
}

module "monitoring" {
  source                     = "monitoring"
  gf-security-admin-password = "${var.gf-security-admin-password}"
  domain                     = "bb8.fun"
  transmission               = "${module.docker.names-transmission}"
  traefik-labels     = "${var.traefik-common-labels}"
}

module "digitalocean" {
  source = "digitalocean"
}

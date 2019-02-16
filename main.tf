module "cloudflare" {
  source = "cloudflare"
  domain = "bb8.fun"
  ips    = "${var.ips}"
}

module "docker" {
  source              = "docker"
  web_username        = "${var.web_username}"
  web_password        = "${var.web_password}"
  cloudflare_key      = "${var.cloudflare_key}"
  cloudflare_email    = "bb8@captnemo.in"
  wiki_session_secret = "${var.wiki_session_secret}"
  networks-mongorocks = "${module.db.networks-mongorocks}"
  ips                 = "${var.ips}"
  domain              = "bb8.fun"
}

module "db" {
  source                 = "db"
  postgres-root-password = "${var.postgres-root-password}"
  ips                    = "${var.ips}"
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

  traefik-network-id = "${module.docker.traefik-network-id}"
}

module "opml" {
  source             = "opml"
  domain             = "opml.bb8.fun"
  client-id          = "${var.opml-github-client-id}"
  client-secret      = "${var.opml-github-client-secret}"
  traefik-network-id = "${module.docker.traefik-network-id}"
}

module "radicale" {
  source = "radicale"
  domain = "radicale.bb8.fun"
}

module "resilio" {
  source             = "resilio"
  domain             = "sync.bb8.fun"
  traefik-labels     = "${var.traefik-common-labels}"
  ips                = "${var.ips}"
  traefik-network-id = "${module.docker.traefik-network-id}"
}

module "media" {
  source             = "media"
  domain             = "bb8.fun"
  traefik-labels     = "${var.traefik-common-labels}"
  ips                = "${var.ips}"
  traefik-network-id = "${module.docker.traefik-network-id}"
}

module "monitoring" {
  source                     = "monitoring"
  gf-security-admin-password = "${var.gf-security-admin-password}"
  domain                     = "bb8.fun"
  transmission               = "${module.media.names-transmission}"
  traefik-labels             = "${var.traefik-common-labels}"
  ips                        = "${var.ips}"
  links-traefik              = "${module.docker.names-traefik}"
  traefik-network-id         = "${module.docker.traefik-network-id}"
}

module "digitalocean" {
  source = "digitalocean"
}

// Used to force access to ISP related resources
# module "tinyproxy" {
#   source = "tinyproxy"
#   ips    = "${var.ips}"
# }

module "abstruse" {
  source             = "abstruse"
  domain             = "ci.bb8.fun"
  traefik-labels     = "${var.traefik-common-labels}"
  traefik-network-id = "${module.docker.traefik-network-id}"
}

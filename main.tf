module "cloudflare" {
  source = "cloudflare"
  domain = "bb8.fun"
  ips    = "${var.ips}"
}

module "mysql" {
  source              = "mysql"
  mysql_root_password = "${var.mysql_root_password}"
}

module "docker" {
  source              = "docker"
  web_username        = "${var.web_username}"
  web_password        = "${var.web_password}"
  mysql_root_password = "${var.mysql_root_password}"
  cloudflare_key      = "${var.cloudflare_key}"
  cloudflare_email    = "bb8@captnemo.in"
  wiki_session_secret = "${var.wiki_session_secret}"
  ips                 = "${var.ips}"
  domain              = "bb8.fun"
}

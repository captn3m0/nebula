provider "docker" {
  host = "tcp://docker.in.bb8.fun:2376"
  cert_path  = "./secrets"
}

provider "cloudflare" {
  email = "bb8@captnemo.in"
  token = "${var.cloudflare_key}"
}

module "cloudflare" {
  source = "cloudflare"
  domain = "bb8.fun"
  proxy  = "sydney.captnemo.in"
  act_ip = "10.242.36.126"
}

module "mysql" {
  source = "mysql"
}

module "docker" {
  source = "docker"
  web_username = "${var.web_username}"
  web_password = "${var.web_password}"
  mysql_root_password = "${var.mysql_root_password}"
  cloudflare_key = "${var.cloudflare_key}"
  cloudflare_email = "bb8@captnemo.in"
  wiki_session_secret = "${var.wiki_session_secret}"
}

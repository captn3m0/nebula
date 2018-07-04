provider "docker" {
  host      = "tcp://docker.vpn.bb8.fun:2376"
  cert_path = "./secrets"
}

provider "cloudflare" {
  email = "bb8@captnemo.in"
  token = "${var.cloudflare_key}"
}

provider "mysql" {
  endpoint = "mysql.vpn.bb8.fun:3306"
  username = "root"
  password = "${var.mysql_root_password}"
}

provider "postgresql" {
  host     = "postgres.vpn.bb8.fun"
  port     = 5432
  username = "postgres"
  password = "${var.postgres-root-password}"
  sslmode  = "disable"
}

provider "digitalocean" {
  token = "${var.digitalocean-token}"
}

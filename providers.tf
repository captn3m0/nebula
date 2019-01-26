provider "docker" {
  host      = "tcp://docker.vpn.bb8.fun:2376"
  cert_path = "./secrets/tatooine"
  version   = "~> 2.0.0"
}

provider "docker" {
  host      = "tcp://docker.dovpn.bb8.fun:2376"
  cert_path = "./secrets/sydney"
  alias     = "sydney"
  version   = "~> 2.0.0"
}

provider "cloudflare" {
  email = "bb8@captnemo.in"
  token = "${var.cloudflare_key}"
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

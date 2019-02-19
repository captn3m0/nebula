provider "docker" {
  host      = "tcp://docker.vpn.bb8.fun:2376"
  cert_path = "./secrets/tatooine"
  version   = "~> 2.0.0"
}

provider "kubernetes" {
  # version = "1.3.0-custom"
  host = "https://k8s.bb8.fun:6443"

  config_path = "${path.root}/k8s/auth/kubeconfig"
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

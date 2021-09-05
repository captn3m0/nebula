provider "docker" {
  host      = "tcp://docker.vpn.bb8.fun:2376"
  cert_path = "./secrets/tatooine"
  version   = "~> 2.7.2"
}

provider "docker" {
  host      = "tcp://docker.dovpn.bb8.fun:2376"
  cert_path = "./secrets/sydney"
  version   = "~> 2.7.2"
  alias     = "sydney"
}

provider "kubernetes" {
  # version = "1.3.0-custom"
  host = "https://k8s.bb8.fun:6443"

  config_path = "${path.root}/k8s/auth/kubeconfig"
}

provider "cloudflare" {
  email   = "bb8@captnemo.in"
  api_key = data.pass_password.cloudflare_key.password
}

provider "postgresql" {
  host     = "postgres.vpn.bb8.fun"
  port     = 5432
  username = "postgres"
  password = data.pass_password.postgres-root-password.password
  sslmode  = "disable"
}

provider "digitalocean" {
  token = data.pass_password.digitalocean-token.password
}

provider "pass" {
  store_dir     = "/home/nemo/.password-store/Nebula/"
  refresh_store = false
}


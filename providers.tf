provider "docker" {
  host      = "tcp://docker.vpn.bb8.fun:2376"
  cert_path = "./secrets/tatooine"
}

provider "docker" {
  host      = "tcp://docker.dovpn.bb8.fun:2376"
  cert_path = "./secrets/sydney"
  alias     = "sydney"
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
}

terraform {
  required_version = ">= 1.3.0"
  required_providers {
    pass = {
      source = "camptocamp/pass"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    postgresql = {
      source = "cyrilgdn/postgresql"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.23"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}


# Configure the GitHub Provider
provider "github" {}

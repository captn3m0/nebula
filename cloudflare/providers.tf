terraform {
  required_version = ">= 1.3.0"
  required_providers {
    pass = {
      source = "camptocamp/pass"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.52"
    }
  }
}

provider "pass" {
}

provider "cloudflare" {
  email   = "bb8@captnemo.in"
  api_key = data.pass_password.cloudflare_key.password
}

provider "cloudflare" {
  alias     = "global"
  api_token = trimspace(split("\n", data.pass_password.certmanager_tatooine_token.password)[0])
}

data "pass_password" "cloudflare_key" {
  path = "Nebula/CLOUDFLARE_KEY"
}

data "pass_password" "certmanager_tatooine_token" {
  path = "Nebula/CERTMANAGER_TATOOINE"
}
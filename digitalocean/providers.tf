terraform {
  required_version = ">= 1.3.0"
  required_providers {
    pass = {
      source = "camptocamp/pass"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}

provider "pass" {
}

provider "digitalocean" {
  token = data.pass_password.digitalocean-token.password
}

data "pass_password" "digitalocean-token" {
  path = "Nebula/DO_TOKEN"
}

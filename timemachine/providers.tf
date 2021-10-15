terraform {
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
    }
  }
}

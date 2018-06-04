variable "domain" {
  description = "domain to be used by traefik"
}

variable "traefik-labels" {
  type = "map"
}

variable "traefik-network-id" {}

variable "domain" {
  type = "string"
}

variable "db-password" {}
variable "postgres-network-id" {}

variable "traefik-labels" {
  type = "map"
}

variable "release" {
  description = "miniflux version"
  type        = "string"
}

variable "traefik-network-id" {}

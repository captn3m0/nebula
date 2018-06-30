variable "domain" {
  type = "string"
}

variable "db-password" {}
variable "postgres-network-id" {}

variable "traefik-labels" {
  type = "map"
}

variable "traefik-network-id" {}

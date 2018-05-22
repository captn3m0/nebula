variable "domain" {
  type = "string"
}

variable "db-password" {}
variable "app-key" {}
variable "hash-salt" {}
variable "smtp-password" {}

variable "traefik-labels" {
  type = "map"
}

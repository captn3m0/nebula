variable "traefik-labels" {
  type = "map"
}

variable "domain" {}

variable "ips" {
  type = "map"
}

variable "secret-key" {}
variable "internal-token" {}
variable "smtp-password" {}
variable "lfs-jwt-secret" {}
variable "mysql-password" {}

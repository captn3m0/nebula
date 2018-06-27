variable "domain" {
  type = "string"
}

variable "mysql_password" {}
variable "postgres-network-id" {}

variable "traefik-labels" {
  type = "map"
}

variable "traefik-network-id" {}

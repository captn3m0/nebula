variable "domain" {
  type = "string"
}

variable "links-emby" {}
variable "links-transmission" {}
variable "links-mariadb" {}
variable "airsonic-smtp-password" {}
variable "airsonic-db-password" {}

variable "traefik-labels" {
  type = "map"
}

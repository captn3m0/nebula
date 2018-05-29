variable "domain" {
  type = "string"
}

variable "links-emby" {}
variable "links-transmission" {}
variable "links-mariadb" {}
variable "links-mongorocks" {}
variable "airsonic-smtp-password" {}
variable "airsonic-db-password" {}

variable "traefik-labels" {
  type = "map"
}

// TODO: Remove duplication
variable "basic_auth" {
  default = "tatooine:$2y$05$iPbatint3Gulbs6kUtyALO9Yq5sBJ..aiF82bcIziH4ytz9nFoPr6,reddit:$2y$05$ghKxSydYCpAT8r2VVMDmWO/BBecghGfLsRJUkr3ii7XxPyxBqp8Oy"
}

variable "ips" {
  type = "map"
}

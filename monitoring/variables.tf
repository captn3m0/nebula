variable "gf-security-admin-password" {
  type = "string"
}

variable "domain" {
  type = "string"
}

variable "transmission" {
  type = "string"
}

variable "links-traefik" {
  type = "string"
}

variable "alert-slack-username" {
  default = "Prometheus"
}

variable "alert-slack-channel" {
  default = "#notifications"
}

variable "alert-slack-incoming-webhook" {
  default = "https://hooks.slack.com/whatever"
}

variable "basic_auth" {
  default = "tatooine:$2y$05$iPbatint3Gulbs6kUtyALO9Yq5sBJ..aiF82bcIziH4ytz9nFoPr6"
}

variable "traefik-labels" {
  type = "map"
}

variable "ips" {
  type = "map"
}

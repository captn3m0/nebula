variable "domain" {
  type = string
}

# variable "airsonic-smtp-password" {}

variable "traefik-labels" {
  type = map(string)
}

// TODO: Remove duplication
variable "basic_auth" {
  default = "tatooine:$2y$05$iPbatint3Gulbs6kUtyALO9Yq5sBJ..aiF82bcIziH4ytz9nFoPr6,reddit:$2y$05$ghKxSydYCpAT8r2VVMDmWO/BBecghGfLsRJUkr3ii7XxPyxBqp8Oy"
}

variable "ips" {
  type = map(string)
}

variable "traefik-network-id" {
}

variable "lastfm_api_key" {
  description = "Navidrome Configuration for lastfm_api_key"
  type        = string
}

variable "lastfm_secret" {
  description = "Navidrome Configuration for lastfm_secret"
  type        = string
}

variable "spotify_id" {
  description = "Navidrome Configuration for spotify_id"
  type        = string
}

variable "spotify_secret" {
  description = "Navidrome Configuration for spotify_secret"
  type        = string
}


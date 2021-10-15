variable "web_username" {
  type = string
}

variable "web_password" {
  type = string
}

variable "cloudflare_key" {
  type        = string
  description = "cloudflare API Key"
}

variable "cloudflare_email" {
  type        = string
  description = "cloudflare email address"
}

# Bcrypt
variable "basic_auth" {
  default = "tatooine:$2y$05$iPbatint3Gulbs6kUtyALO9Yq5sBJ..aiF82bcIziH4ytz9nFoPr6,reddit:$2y$05$ghKxSydYCpAT8r2VVMDmWO/BBecghGfLsRJUkr3ii7XxPyxBqp8Oy"
}

# 30 days
variable "hsts_max_age" {
  default = "2592000"
}

variable "xfo_allow" {
  default = "ALLOW-FROM https://home.bb8.fun/"
}

variable "xpoweredby" {
  default = "X-Powered-By:Allomancy||X-Server:Blackbox"
}

variable "refpolicy" {
  default = "no-referrer"
}

variable "wiki_session_secret" {
  type = string
}

variable "domain" {
  type = string
}

variable "ips" {
  type = map(string)
}

# variable "links-mariadb" {}

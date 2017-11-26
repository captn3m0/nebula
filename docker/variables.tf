variable "web_username" {
  type = "string"
}

variable "web_password" {
  type = "string"
}

variable "mysql_root_password" {
  type = "string"
}

variable "cloudflare_key" {
  type = "string"
  description = "cloudflare API Key"
}

variable "cloudflare_email" {
  type = "string"
  description = "cloudflare email address"
}

# Bcrypt
variable "basic_auth" {
  default = "tatooine:$2y$05$iPbatint3Gulbs6kUtyALO9Yq5sBJ..aiF82bcIziH4ytz9nFoPr6,reddit:$2y$05$ghKxSydYCpAT8r2VVMDmWO/BBecghGfLsRJUkr3ii7XxPyxBqp8Oy"
}

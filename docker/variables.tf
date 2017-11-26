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

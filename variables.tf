variable "cloudflare_key" {
  type        = "string"
  description = "cloudflare API Key"
}

variable "web_username" {
  type = "string"
}

variable "web_password" {
  type = "string"
}

variable "mysql_root_password" {
  type = "string"
}

variable "wiki_session_secret" {
  type = "string"
}

variable "ips" {
  type = "map"
  default = {
    eth0 = "192.168.1.111"
    tun0 = "10.8.0.14"
    static = "139.59.48.222"
  }
}

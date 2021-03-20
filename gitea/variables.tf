variable "traefik-labels" {
  type = map(string)
}

variable "domain" {
}

variable "ips" {
  type = map(string)
}

variable "secret-key" {
}

variable "internal-token" {
}

variable "smtp-password" {
}

variable "lfs-jwt-secret" {
}

variable "oauth2-jwt-secret" {
}

variable "mysql-password" {
}

variable "traefik-network-id" {
}


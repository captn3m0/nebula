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

variable "postgres-root-password" {
  type = "string"
}

variable "gitea-mysql-password" {}

variable "wiki_session_secret" {
  type = "string"
}

variable "ips" {
  type = "map"

  default = {
    eth0   = "192.168.1.111"
    tun0   = "10.8.0.14"
    static = "139.59.48.222"
  }
}

variable "gf-security-admin-password" {
  type = "string"
}

variable "gitea-secret-key" {}
variable "gitea-internal-token" {}
variable "gitea-smtp-password" {}
variable "gitea-lfs-jwt-secret" {}
variable "digitalocean-token" {}
variable "airsonic-smtp-password" {}

variable "traefik-common-labels" {
  type = "map"

  default = {
    "traefik.enable" = "true"

    // HSTS
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"

    // X-Powered-By, Server headers
    "traefik.frontend.headers.customResponseHeaders" = "X-Powered-By:Allomancy||X-Server:Blackbox"

    // X-Frame-Options
    "traefik.frontend.headers.customFrameOptionsValue" = "ALLOW-FROM https://bb8.fun/"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.browserXSSFilter"        = "true"

    // Use the Traefik network
    "traefik.docker.network" = "traefik"
  }
}

variable "timemachine-password-2" {}
variable "timemachine-password-1" {}

variable "opml-github-client-id" {}
variable "opml-github-client-secret" {}
variable "miniflux-db-password" {}

variable "monica-db-password" {}
variable "monica-app-key" {}
variable "monica-hash-salt" {}
variable "monica-smtp-password" {}

variable "root-domain" {
  description = "root domain for most applications"
  default     = "bb8.fun"
}

variable "znc_pass" {}
variable "znc_user" {}

variable "outline_smtp_password" {}
variable "outline_secret_key" {}
variable "outline_slack_key" {}
variable "outline_slack_secret" {}
variable "outline_slack_app_id" {}
variable "outline_slack_verification_token" {}

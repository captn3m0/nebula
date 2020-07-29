variable "ips" {
  type = "map"

  default = {
    eth0    = "192.168.1.111"
    tun0    = "10.8.0.14"
    dovpn   = "10.8.0.1"
    static  = "139.59.48.222"
    droplet = "139.59.22.234"
  }
}

variable "traefik-common-labels" {
  type = "map"

  default = {
    "traefik.enable" = "true"

    // HSTS
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"

    // X-Powered-By, Server headers
    "traefik.frontend.headers.customResponseHeaders" = "X-Powered-By:Allomancy||X-Server:Blackbox||X-Clacks-Overhead:GNU Terry Pratchett"

    // X-Frame-Options
    "traefik.frontend.headers.customFrameOptionsValue" = "ALLOW-FROM https://bb8.fun/"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.browserXSSFilter"        = "true"

    // Use the Traefik network
    "traefik.docker.network" = "traefik"
  }
}

variable "root-domain" {
  description = "root domain for most applications"
  default     = "bb8.fun"
}

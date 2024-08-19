variable "ips" {
  type = map(string)

  default = {
    eth0    = "192.168.1.111"
    ts = "100.107.166.2"
    static  = "139.59.48.222"
    ceylon = "10.139.144.88"
  }
}

variable "traefik-common-labels" {
  type = map(string)

  default = {
    "traefik.enable" = "true"
    // HSTS
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"
    // X-Powered-By, Server headers
    "traefik.frontend.headers.customResponseHeaders" = "X-Powered-By:Allomancy||X-Server:Blackbox||X-Clacks-Overhead:GNU Terry Pratchett"
    "traefik.frontend.headers.browserXSSFilter"      = "true"
    // Use the Traefik network
    "traefik.docker.network" = "traefik"
  }
}

variable "root-domain" {
  description = "root domain for most applications"
  default     = "bb8.fun"
}


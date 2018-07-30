locals {
  traefik-common-labels {
    "traefik.enable" = "true"

    // HSTS
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"

    // X-Powered-By, Server headers
    "traefik.frontend.headers.customResponseHeaders" = "${var.xpoweredby}"
    "traefik.frontend.headers.contentTypeNosniff"    = "true"
    "traefik.frontend.headers.browserXSSFilter"      = "true"

    "traefik.docker.network" = "traefik"
  }
}

locals {
  traefik_common_labels {
    "traefik.enable" = "true"

    // HSTS
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"

    // X-Powered-By, Server headers
    "traefik.frontend.headers.customResponseHeaders" = "${var.xpoweredby}"

    // X-Frame-Options
    "traefik.frontend.headers.customFrameOptionsValue" = "${var.xfo_allow}"
    "traefik.frontend.headers.contentTypeNosniff"      = "true"
    "traefik.frontend.headers.browserXSSFilter"        = "true"

    "traefik.docker.network" = "traefik"
  }
}

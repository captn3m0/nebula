locals {
  traefik_common_labels = {
    "traefik.frontend.passHostHeader" = "true"
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds" = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"
    # "traefik.frontend.headers.customResponseHeaders" = "${var.xpoweredby}"
    # "traefik.frontend.headers.customFrameOptionsValue" = "${var.xfo_allow}"
  }
}

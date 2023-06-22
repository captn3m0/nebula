locals {
  default_labels = {
    "managed.by" = "nebula"
  }

  web = {
    "traefik.port"          = var.web.port != null ? var.web.port : 80
    "traefik.frontend.rule" = var.web.host != null ? "Host:${var.web.host}" : "Host:example.invalid"
    "traefik.protocol"      = var.web.protocol != null ? var.web.protocol : "http"
  }

  traefik_common_labels = {
    "traefik.enable" = "true"
    // HSTS
    "traefik.frontend.headers.SSLTemporaryRedirect" = "true"
    "traefik.frontend.headers.STSSeconds"           = "2592000"
    "traefik.frontend.headers.STSIncludeSubdomains" = "false"
    // X-Powered-By, Server headers
    "traefik.frontend.headers.customResponseHeaders" = var.xpoweredby
    "traefik.frontend.headers.contentTypeNosniff"    = "true"
    "traefik.frontend.headers.browserXSSFilter"      = "true"
    "traefik.docker.network"                         = "traefik"
  }

  # if var.web.auth == true
  traefik_auth_labels = {
    "traefik.frontend.auth.basic" = var.auth_header
  }

  resource = {
    memory      = lookup(var.resource, "memory", 64)
    memory_swap = lookup(var.resource, "memory_swap", 128)
  }

  labels = merge(
    # Default labels are applied to every container
    local.default_labels,
    # Add the common traefik labels
    var.web.expose ? local.traefik_common_labels : null,
    # Apply the overwritten web labels only if the container is exposed
    var.web.expose ? local.web : null,
    # And finally a label for Basic Authentication if the service wants it
    var.web.auth != null ? (var.web.auth ? local.traefik_auth_labels : null) : null,

    var.labels,
  )

  networks = concat(var.networks, var.web.expose ? ["traefik"] : [])
}

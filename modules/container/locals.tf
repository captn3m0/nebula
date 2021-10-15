locals {
  default_labels = {
    "managed.by" = "nebula"
  }

  # if var.web.expose == true
  web = {
    "traefik.port"          = var.web.port != null ? var.web.port : 80
    "traefik.frontend.rule" = var.web.host != null ? "Host:${var.web.host}" : "Host:example.invalid"
    "traefik.protocol"      = var.web.protocol != null ? var.web.protocol : "http"
  }

  # if var.web.expose == true
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

  labels_web            = var.web.expose ? local.web : null
  labels_traefik_common = var.web.expose ? local.traefik_common_labels : null
  labels_traefik_auth   = var.web.auth != null ? (var.web.auth ? local.traefik_auth_labels : null) : null

  labels = merge(
    local.default_labels,
    local.labels_web,
    local.labels_traefik_common,
    local.labels_traefik_auth,
  )
}

resource "null_resource" "temp" {
  triggers = {
    temp = jsonencode(local.labels_web)
  }
}

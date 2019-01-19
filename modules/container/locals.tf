locals {
  default_labels {
    "managed.by" = "nebula"
  }

  web {
    "traefik.port"          = "${lookup(var.web, "port", "80")}"
    "traefik.frontend.rule" = "Host:${lookup(var.web, "host", "example.invalid")}"
    "traefik.protocol"      = "${lookup(var.web, "protocol", "http")}"
  }

  resource {
    memory      = "${lookup(var.resource, "memory", 64)}"
    memory_swap = "${lookup(var.resource, "memory_swap", 128)}"
  }

  traefik_common_labels {
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

  traefik_auth_labels {
    "traefik.frontend.auth.basic" = "${var.auth_header}"
  }
}

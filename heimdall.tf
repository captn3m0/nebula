module "heimdall" {
  name   = "heimdall"
  source = "modules/container"
  image  = "linuxserver/heimdall:latest"

  // Default is port 80
  web {
    expose    = true
    port      = 443
    protocol  = "https"
    basicauth = "true"
    host      = "home.bb8.fun"
  }

  networks = "${list(module.docker.traefik-network-id)}"

  env = [
    "TZ=Asia/Kolkata",
  ]
}

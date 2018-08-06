module "requestbin" {
  name   = "requestbin"
  source = "./modules/container"
  image  = "jankysolutions/requestbin:latest"

  // Default is port 80
  web {
    expose = true
    port   = "8000"
    host   = "requestbin.${var.root-domain}"
  }

  networks = "${list(module.docker.traefik-network-id)}"
}

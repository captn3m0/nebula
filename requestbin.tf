module "requestbin" {
  name   = "requestbin"
  source = "./modules/container"
  image  = "jankysolutions/requestbin:latest"

  // Default is port 80
  web {
    expose = true
    host   = "requestbin.${var.root-domain}"
  }

  networks              = "${list(module.docker.traefik-network-id)}"
  destroy_grace_seconds = 10
  must_run              = true
}

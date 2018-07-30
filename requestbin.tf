module "requestbin" {
  name   = "requestbin"
  source = "./modules/container"
  image  = "jankysolutions/requestbin:latest"

  // Default is port 80
  expose-web = true
  web-domain = "requestbin.${var.root-domain}"

  networks = "${list(module.docker.traefik-network-id)}"

  destroy_grace_seconds = 10
  must_run              = true
}

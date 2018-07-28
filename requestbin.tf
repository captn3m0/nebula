module "requestbin" {
  name   = "requestbin"
  source = "./modules/container"
  image  = "jankysolutions/requestbin:latest"

  labels = "${merge(
    var.traefik-common-labels, map(
      "traefik.port", 8000,
      "traefik.frontend.rule","Host:requestbin.${var.root-domain}"
  ))}"

  networks = "${list(module.docker.traefik-network-id)}"

  destroy_grace_seconds = 10
  must_run              = true
}

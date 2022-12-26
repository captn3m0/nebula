module "jupyter" {
  name   = "jupyter"
  source = "./modules/container"
  image  = "jupyter/scipy-notebook"
  resource = {
    memory      = 1024
    memory_swap = 4096
  }
  web = {
    expose = "true"
    host   = "j.${var.root-domain}"
    port = 8888
  }
  networks = ["bridge"]
  gpu = true
}

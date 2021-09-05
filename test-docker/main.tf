module "echo-server" {
  source = "../modules/container"
  name   = "echo-server"
  image  = "jmalloc/echo-server:latest"

  web = {
    expose = "true"
    port   = 8080
    host   = "debug.${var.root-domain},debug.in.${var.root-domain}"
  }
}

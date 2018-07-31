module "echo-server" {
  source = "../modules/container"
  name   = "echo-server"
  image  = "jmalloc/echo-server:latest"

  web {
    expose = true
    port   = 8080
    domain = "debug.${var.domain},debug.in.${var.domain}"
  }
}

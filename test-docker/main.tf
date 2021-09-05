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

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

module "echo-server" {
  source = "../modules/container"
  name   = "echo-server"
  image  = "jmalloc/echo-server:latest"

  web = {
    expose = false
    port   = 8080
    host   = "debug.example.com,debug.in.example.com"
  }

  uploads = [
    {
      file    = "/x"
      content = "adadadad"
    },
    {
      file           = "/y"
      content_base64 = "Cg=="
    }
  ]

  networks = ["media"]
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

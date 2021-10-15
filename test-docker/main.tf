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
}

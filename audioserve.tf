module "audioserve" {
  name   = "audioserve"
  source = "modules/container"

  web {
    expose = true
    port   = "3000"
    host   = "audioserve.${var.root-domain}"
    auth   = "true"
  }

  restart = "always"

  image = "izderadicka/audioserve"

  volumes = [
    {
      host_path      = "/mnt/xwing/media/Music/Audiobooks"
      container_path = "/audiobooks"
    },
  ]

  networks_advanced = [{
    name = "traefik"
  }]
}

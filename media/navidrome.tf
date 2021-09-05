module "navidrome" {
  source = "../modules/container"
  image  = "deluan/navidrome"
  name   = "navidrome"

  user = 1004

  resource = {
    memory      = "1024"
    memory_swap = "1024"
  }

  web = {
    port   = 4533
    host   = "music.bb8.fun"
    expose = true
  }

  labels = {
    "traefik.read.frontend.headers.contentTypeNosniff" = "false"
  }

  env = [
    "ND_SCANINTERVAL=1h",
    "ND_LOGLEVEL=info",
    "ND_SESSIONTIMEOUT=300h",
    "ND_BASEURL=",
    "ND_AUTOIMPORTPLAYLISTS=false",
    "ND_LASTFM_APIKEY=${var.lastfm_api_key}",
    "ND_LASTFM_SECRET=${var.lastfm_secret}",
    "ND_SPOTIFY_ID=${var.spotify_id}",
    "ND_SPOTIFY_SECRET=${var.spotify_secret}",
  ]

  # TODO FIXME
  # networks = [docker_network.media.id, data.docker_network.bridge.id]

  volumes = [
    {
      host_path      = "/mnt/xwing/data/navidrome"
      container_path = "/data"
    },
    {
      host_path      = "/mnt/xwing/media/Music"
      container_path = "/music"
      read_only      = true
    },
  ]
}


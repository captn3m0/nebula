module "gonic" {
  source = "../modules/container"
  image  = "sentriz/gonic"
  name   = "gonic"

  resource {
    memory      = "512"
    memory_swap = "512"
  }

  web {
    port   = 80
    host   = "gonic.bb8.fun"
    expose = true
  }

  env = [
    "GONIC_SCAN_INTERVAL=60",
    "GONIC_MUSIC_PATH=/music",
    "GONIC_DB_PATH=/data/gonic.db"
  ]

  networks = "${list(docker_network.media.id, data.docker_network.bridge.id)}"

  volumes = [
    {
      host_path      = "/mnt/xwing/config/gonic"
      container_path = "/data"
    },
    {
      host_path      = "/mnt/xwing/media/Music"
      container_path = "/music"
      read_only      = true
    }
  ]
}

// Run a second instance, just for Audiobooks
module "gonic-audio" {
  source = "../modules/container"
  image  = "sentriz/gonic"
  name   = "gonic-audio"

  resource {
    memory      = "256"
    memory_swap = "256"
  }

  web {
    port   = 80
    host   = "audiobooks.bb8.fun"
    expose = true
  }

  env = [
    "GONIC_SCAN_INTERVAL=60",
    "GONIC_MUSIC_PATH=/books",
    "GONIC_DB_PATH=/data/gonic-audio.db"
  ]

  networks = "${list(docker_network.media.id, data.docker_network.bridge.id)}"

  volumes = [
    {
      host_path      = "/mnt/xwing/config/gonic"
      container_path = "/data"
    },
    {
      host_path      = "/mnt/xwing/media/Music/Audiobooks"
      container_path = "/books"
      read_only      = true
    }
  ]
}

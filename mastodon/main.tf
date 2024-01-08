module "mastodon-web" {
  name   = "mastodon-web"
  source = "../modules/container"
  image  = "ghcr.io/mastodon/mastodon:v${local.version}"
  keep_image = true

  networks = ["mastodon", "traefik", "external", "postgres"]
  dns = [
    "192.168.1.111",
    "1.1.1.1"
  ]

  labels = {
    "traefik.frontend.headers.STSPreload"           = "true"
    "traefik.frontend.headers.STSIncludeSubdomains" = "true"
    "traefik.frontend.headers.STSSeconds"           = "31536000"
  }

  env = concat(local.env,[
    "MAX_THREADS=4",
    "WEB_CONCURRENCY=5"
  ])

  command = [
    "bash",
    "-c",
    "rm -f /mastodon/tmp/pids/server.pid; bundle exec rake db:migrate; bundle exec rails s -p 3000"
  ]

  volumes = [{
    container_path = "/mastodon/public/system"
    host_path      = "/mnt/xwing/data/mastodon"
  }]

  web = {
    expose = "true"
    host = "tatooine.club"
    port = 3000
  }

  resource = {
    memory      = 2048
    memory_swap = 2048
  }
}


module "mastodon-streaming" {
  name   = "mastodon-streaming"
  source = "../modules/container"
  image  = "ghcr.io/mastodon/mastodon:v${local.version}"
  keep_image = true

  # 24 threads for Streaming
  env = concat(local.env,[
    "DB_POOL=8",
    "STREAMING_CLUSTER_NUM=4"
  ])

  networks = ["postgres", "external", "mastodon"]
  dns = [
    "192.168.1.111",
    "1.1.1.1"
  ]

  command = [
    "node",
    "./streaming"
  ]

  web = {
    expose = "false"
  }

  resource = {
    memory      = 512
    memory_swap = 512
  }
}

module "mastodon-sidekiq" {
  name   = "mastodon-sidekiq"
  source = "../modules/container"
  image  = "ghcr.io/mastodon/mastodon:v${local.version}"
  keep_image = true
  env = concat(local.env,[
    "DB_POOL=50"
  ])

   web = {
    expose = "false"
  }

  networks = ["postgres", "external", "mastodon"]
  dns = [
    "192.168.1.111",
    "1.1.1.1"
  ]

  command = [
    "bundle",
    "exec",
    "sidekiq"
  ]

  volumes =  [{
      container_path = "/mastodon/public/system"
      host_path      = "/mnt/xwing/data/mastodon"
    }]

  resource = {
    memory      = 2048
    memory_swap = 2048
  }
}

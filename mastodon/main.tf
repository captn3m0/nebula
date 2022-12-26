module "mastodon-web" {
  name   = "mastodon-web"
  source = "../modules/container"
  image  = "tootsuite/mastodon:v4.0"

  networks = ["mastodon", "traefik", "external", "postgres"]

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
    memory      = 1024
    memory_swap = 1024
  }
}


module "mastodon-streaming" {
  name   = "mastodon-streaming"
  source = "../modules/container"
  image  = "tootsuite/mastodon:v4.0"
  # 24 threads for Streaming
  env = concat(local.env,[
    "DB_POOL=8",
    "STREAMING_CLUSTER_NUM=4"
  ])

  networks = ["postgres", "external", "mastodon"]

  command = [
    "node",
    "./streaming"
  ]

  web = {
    expose = "false"
  }

  resource = {
    memory      = 1024
    memory_swap = 1024
  }
}


module "mastodon-sidekiq" {
  name   = "mastodon-sidekiq"
  source = "../modules/container"
  image  = "tootsuite/mastodon:v4.0"
  env = concat(local.env,[
    "DB_POOL=50"
  ])

   web = {
    expose = "false"
  }

  networks = ["postgres", "external", "mastodon"]

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
    memory      = 1024
    memory_swap = 1024
  }
}

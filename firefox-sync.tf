module "firefox-sync" {
  name   = "firefox-sync"
  source = "./modules/container"
  image  = "mozilla/syncserver:latest"

  // Default is port 80
  web = {
    expose = true
    port   = "5000"
    host   = "firesync.${var.root-domain}"
  }

  resource = {
    memory      = "400"
    memory_swap = "400"
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/data/firefox-sync"
      container_path = "/data"
    },
  ]

  env = [
    "SYNCSERVER_PUBLIC_URL=https://firesync.${var.root-domain}",
    "SYNCSERVER_SECRET=${data.pass_password.syncserver_secret.password}",
    "SYNCSERVER_SQLURI=sqlite:////data/sync.db",
    "SYNCSERVER_BATCH_UPLOAD_ENABLED=true",
    "SYNCSERVER_FORCE_WSGI_ENVIRON=true",
    "PORT=5000",
  ]

  networks_advanced = [
    {
      name = "traefik"
    },
    {
      name = "bridge"
    },
  ]
}


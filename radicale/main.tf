module "container" {
  name   = "radicale"
  source = "../modules/container"
  image  = "tomsquest/docker-radicale:amd64"

  resource {
    memory      = 2000
    memory_swap = 2000
  }

  web {
    expose = true
    port   = 5232
    host   = "${var.domain}"
  }

  volumes = [
    {
      host_path      = "/mnt/xwing/data/radicale"
      container_path = "/data"
    },
    {
      host_path      = "/mnt/xwing/config/radicale"
      container_path = "/config"
    },
  ]

  uploads = [
    {
      content = <<EOT
# See radicale.org/configuration/
[server]
hosts = 0.0.0.0:5232

# Max parallel connections
max_connections = 10

[auth]
# Authentication method
# Value: none | htpasswd | remote_user | http_x_remote_user
type = htpasswd
htpasswd_filename = /config/users
htpasswd_encryption = bcrypt

[storage]
filesystem_folder = /data/collections

[logging]
level=warning

[headers]
# Additional HTTP headers
X-Powered-By: Allomancy
Server: Blackbox
EOT
      file    = "/config/config"
    },
    {
      content = <<EOT
nemo:$2y$05$vC1WTAuKn2xuDYZ6I3ucxuPnCrtZrVKzdDHSYhqCegi97RM/pdzXW
axy:$2b$10$iqCLs3F1IRDBoSGxGlsOFO9C3peh8QH14hMnHN4o6oqu21PWL9vu2
EOT
      file    = "/config/users"
    },
  ]
}

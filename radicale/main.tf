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

# Message displayed in the client when a password is needed
realm = Authentication required

[auth]

# Authentication method
# Value: none | htpasswd | remote_user | http_x_remote_user
type = htpasswd
htpasswd_filename = /config/users

[storage]
filesystem_folder = /data/collections

[logging]

# For more information about the syntax of the configuration file, see:
# http://docs.python.org/library/logging.config.html
# config = /config/logging

[headers]

# Additional HTTP headers
X-Powered-By: Allomancy
Server: Blackbox
EOT

      file = "/config/config"
    },
    {
      content = <<EOT
[loggers]
keys = root

[handlers]
keys = file

[formatters]
keys = full

[logger_root]
# Change this to DEBUG or INFO for higher verbosity.
level = WARNING
handlers = file

[handler_file]
class = FileHandler
# Specify the output file here.
args = ('/var/log/radicale/log',)
formatter = full

[formatter_full]
format = %(asctime)s - [%(thread)x] %(levelname)s: %(message)s
EOT

      file = "/config/logging"
    },
    {
      content = "nemo:$2y$05$vC1WTAuKn2xuDYZ6I3ucxuPnCrtZrVKzdDHSYhqCegi97RM/pdzXW"
      file    = "/config/users"
    },
  ]
}

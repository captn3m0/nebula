# module "pulse-pshtt" {
#   name   = "pulse-pshtt"
#   source = "modules/container"
#   image  = "dhsncats/pshtt:0.5.2"
#   volumes = [
#     {
#       host_path      = "/mnt/xwing/data/pulse"
#       container_path = "/home/pshtt"
#     },
#   ]
#   web {
#     expose = false
#     host   = ""
#   }
#   command  = ["--debug", "--timeout=3", "--cache-third-parties=./cache", "domains.csv"]
#   must_run = "false"
#   restart  = "no"
#   # nameserver = "192.168.1.1"
#   networks = ["bridge"]
#   resource = {
#     memory = 2048
#   }
# }

# module "kavita" {
#   name   = "kavita"
#   source = "./modules/container"
#   image  = "kizaing/kavita:latest"

#   web = {
#     expose = true
#     port   = 5000
#     host   = "kavita.bb8.fun"
#   }

#   resource = {
#     memory      = 1024
#     memory_swap = 1024
#   }

#   volumes = [
#     {
#       host_path      = "/mnt/xwing/media/EBooks"
#       container_path = "/ebooks"
#     },
#     {
#       host_path      = "/mnt/xwing/config/kavita"
#       container_path = "/kavita/config"
#     }
#   ]

#   networks = ["traefik"]

#   env = [
#     "TZ=Asia/Kolkata",
#   ]
# }

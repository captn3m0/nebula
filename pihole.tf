module "pihole" {
  name   = "pihole"
  source = "modules/container"

  web {
    expose = true
    port   = "80"
    host   = "dns.in.${var.root-domain}"
  }

  restart = "always"

  image = "pihole/pihole"

  ports = [{
    internal = "53"
    external = "53"
    ip       = "192.168.1.111"
    protocol = "udp"
  }]

  env = [
    "ServerIP=192.168.1.111",
    "WEBPASSWORD=${var.pihole_password}",
    "DNS1=172.30.0.2",
    "DNS2=no",
    "VIRTUAL_HOST=dns.in.${var.root-domain}",
  ]

  volumes = [
    {
      host_path      = "/mnt/xwing/config/pihole"
      container_path = "/etc/pihole"
    },
    {
      host_path      = "/mnt/xwing/config/pihole-dnsmasq.d"
      container_path = "/etc/dnsmasq.d"
    },
  ]

  networks_advanced = [{
    name = "dns"
  },
    {
      name = "traefik"
    },
  ]

  capabilities = [{
    add = ["NET_ADMIN"]
  }]

  dns = ["127.0.0.1", "9.9.9.9", "1.1.1.1"]
}

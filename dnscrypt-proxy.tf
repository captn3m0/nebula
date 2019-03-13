// This is a completely isolated container
// used by pihole
module "dnscrypt" {
  name   = "dnscrypt-proxy"
  source = "modules/container"

  image = "mattbodholdt/dnscrypt-proxy"

  restart = "always"

  networks_advanced = [{
    name         = "dns"
    aliases      = ["dnscrypt", "dnscrypt-proxy"]
    ipv4_address = "172.30.0.2"
  }]

  dns = ["127.0.0.1"]
}

resource "docker_network" "dns" {
  name     = "dns"
  internal = false

  // 172.20.0.12 - 172.20.0.15
  ipam_config {
    subnet  = "172.30.0.0/29"
    gateway = "172.30.0.1"
  }
}

module "dnscrypt" {
  name   = "dnscrypt-proxy"
  source = "modules/container"

  image = "mattbodholdt/dnscrypt-proxy"

  ports = [{
    internal = "53"
    external = "553"
    ip       = "192.168.1.111"
    protocol = "udp"
  }]

  dns = ["127.0.0.1"]
}

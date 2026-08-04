resource "digitalocean_droplet" "ceylon" {
  image       = "135438931"
  name        = "ceylon.captnemo.in"
  region      = "blr1"
  size        = "s-1vcpu-2gb"
  ipv6        = true
  vpc_uuid    = "dfc20cf3-dc84-11e8-b2cf-3cfdfea9f220"
  monitoring  = true
  resize_disk = true

  volume_ids = ["eae03502-9279-11e8-ab31-0242ac11470b"]

  tags = [
    "bangalore",
    "proxy",
    "ceylon",
    "vpn",
  ]
}

output "droplet_ipv4" {
  value = digitalocean_droplet.ceylon.ipv4_address
}


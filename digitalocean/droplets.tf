resource "digitalocean_droplet" "sydney" {
  image              = ""
  name               = "sydney.captnemo.in"
  region             = "blr1"
  size               = "s-1vcpu-2gb"
  ipv6               = true
  private_networking = true
  resize_disk        = true

  volume_ids = ["eae03502-9279-11e8-ab31-0242ac11470b"]

  tags = [
    "bangalore",
    "proxy",
    "sydney",
    "vpn",
  ]
}

output "droplet_ipv4" {
  value = digitalocean_droplet.sydney.ipv4_address
}


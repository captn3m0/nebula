resource "digitalocean_droplet" "sydney" {
  image              = ""
  name               = "sydney.captnemo.in"
  region             = "blr1"
  size               = "1gb"
  ipv6               = true
  private_networking = true
  resize_disk        = true

  tags = [
    "bangalore",
    "proxy",
    "sydney",
    "vpn",
  ]
}

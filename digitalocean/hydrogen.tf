resource "digitalocean_droplet" "hydrogen" {
  image              = "coreos-stable"
  name               = "hydrogen.bb8.fun"
  region             = "blr1"
  size               = "1gb"
  ipv6               = true
  private_networking = true

  tags = [
    "bangalore",
    "proxy",
    "hydrogen",
    "vpn",
    "monitoring"
  ]

  # user_data = "${ignition_config.hydrogen.rendered}"
}

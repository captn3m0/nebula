resource "digitalocean_floating_ip" "ceylon" {
  droplet_id = digitalocean_droplet.ceylon.id
  region     = digitalocean_droplet.ceylon.region

  # DNS and the anchor-pinned socks proxy egress depend on 139.59.48.222
  lifecycle {
    prevent_destroy = true
  }
}


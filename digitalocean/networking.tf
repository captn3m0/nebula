resource "digitalocean_floating_ip" "ceylon" {
  droplet_id = digitalocean_droplet.ceylon.id
  region     = digitalocean_droplet.ceylon.region
}


resource "digitalocean_floating_ip" "sydney" {
  droplet_id = "${digitalocean_droplet.sydney.id}"
  region     = "${digitalocean_droplet.sydney.region}"
}

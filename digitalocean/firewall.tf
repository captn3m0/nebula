resource "digitalocean_firewall" "outbound" {
  name        = "outbound-allow-all"
  droplet_ids = [digitalocean_droplet.ceylon.id]

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "web" {
  name        = "web-inbound"
  droplet_ids = [digitalocean_droplet.ceylon.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "prosody" {
  name        = "prosody-inbound"
  droplet_ids = [digitalocean_droplet.ceylon.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "5222"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "5269"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "5281"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "k3s_api" {
  name        = "k3s-api-inbound"
  droplet_ids = [digitalocean_droplet.ceylon.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "6443"
    source_addresses = ["109.41.114.133/32"]
  }
}

resource "digitalocean_firewall" "ssh" {
  name        = "ssh-inbound"
  droplet_ids = [digitalocean_droplet.ceylon.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "222"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "24"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}


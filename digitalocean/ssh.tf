resource digitalocean_ssh_key "default" {
  name       = "Hydrogen Key"
  public_key = "${file("/home/nemo/.ssh/hydrogen.pub")}"
}

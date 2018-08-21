resource "docker_network" "mongorocks" {
  name     = "mongorocks"
  driver   = "bridge"
  internal = false

  ipam_config {
    subnet  = "172.20.0.0/29"
    gateway = "172.20.0.1"
  }
}

resource "docker_network" "postgres" {
  name     = "postgres"
  driver   = "bridge"
  internal = true

  ipam_config {
    subnet  = "172.20.0.8/29"
    gateway = "172.20.0.9"
  }
}

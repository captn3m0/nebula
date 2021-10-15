resource "docker_network" "postgres" {
  name     = "postgres"
  driver   = "bridge"
  internal = true

  ipam_config {
    subnet  = "172.20.0.8/29"
    gateway = "172.20.0.9"
  }
}


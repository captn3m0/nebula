resource "docker_network" "media" {
  name   = "media"
  driver = "bridge"

  ipam_config {
    subnet  = "172.18.0.0/24"
    gateway = "172.18.0.1"
  }
}

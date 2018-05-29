resource "docker_network" "mariadb" {
  name   = "mariadb"
  driver = "bridge"

  ipam_config {
    subnet  = "172.19.0.0/28"
    gateway = "172.19.0.1"
  }
}

resource "docker_network" "mongorocks" {
  name   = "mongorocks"
  driver = "bridge"

  ipam_config {
    subnet  = "172.20.0.0/29"
    gateway = "172.20.0.1"
  }
}

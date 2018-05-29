// This is the default network we use
// for any new container
resource "docker_network" "bb8-default" {
  name   = "bb8"
  driver = "bridge"
}

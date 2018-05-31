resource "docker_network" "opml" {
  name   = "opml"
  driver = "bridge"
}

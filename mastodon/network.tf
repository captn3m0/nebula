resource "docker_network" "mastodon" {
  name   = "mastodon"
  driver = "bridge"
  internal = true
}
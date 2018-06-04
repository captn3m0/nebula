resource "docker_network" "traefik" {
  name     = "traefik"
  driver   = "bridge"
  internal = true
}

// Create a small database network
resource "docker_network" "traefik" {
  name = "traefik"

  labels = {
    internal = "true"
    role     = "ingress"
  }

  internal = true
}

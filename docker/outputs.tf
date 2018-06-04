output "lychee-ip" {
  value = "${docker_container.lychee.ip_address}"
}

output "names-traefik" {
  value = "${docker_container.traefik.name}"
}

output "traefik-network-id" {
  value = "${docker_network.traefik.id}"
}

output "auth-header" {
  value = "${var.basic_auth}"
}

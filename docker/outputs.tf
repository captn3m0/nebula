output "lychee-ip" {
  value = "${docker_container.lychee.ip_address}"
}

output "names-traefik" {
  value = "${docker_container.traefik.name}"
}

output "auth-header" {
  value = "${var.basic_auth}"
}

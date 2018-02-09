output "lychee-ip" {
  value = "${docker_container.lychee.ip_address}"
}

output "names-transmission" {
  value = "${docker_container.transmission.name}"
}

output "names-emby" {
  value = "${docker_container.emby.name}"
}

output "names-mariadb" {
  value = "${docker_container.mariadb.name}"
}

output "names-traefik" {
  value = "${docker_container.traefik.name}"
}

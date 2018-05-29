output "names-mariadb" {
  value = "${docker_container.mariadb.name}"
}

output "names-mongorocks" {
  value = "${docker_container.mongorocks.name}"
}

output "names-mariadb" {
  value = "${docker_container.mariadb.name}"
}

output "networks-mongorocks" {
  value = "${docker_network.mongorocks.name}"
}

output "postgres-network-id" {
  value = "${docker_network.postgres.name}"
}

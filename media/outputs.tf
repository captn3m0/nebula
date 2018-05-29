output "names-transmission" {
  value = "${docker_container.transmission.name}"
}

output "names-emby" {
  value = "${docker_container.emby.name}"
}

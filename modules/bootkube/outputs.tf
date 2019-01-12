# output "exit_code" {
#   # TODO: Pick correct exit code
#   # value = "${coalesce(formatlist("%s", docker_container.render.*.exit_code))}"
#   # See https://github.com/hashicorp/terraform/issues/15165
#   value = "${var.mode == "render" ?
#     "${element(concat(docker_container.render.*.exit_code, list("")), 0)}" :
#     "${element(concat(docker_container.start.*.exit_code, list("")), 0)}"
#   }"
# }

output "image" {
  value = "${docker_image.image.latest}"
}

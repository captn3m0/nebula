data "docker_registry_image" "image" {
  name = "${var.image}"
}

resource "docker_image" "image" {
  name          = "${var.image}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
  keep_locally  = "${var.keep_image}"
}

data "docker_network" "traefik" {
  name = "traefik"
}

resource "docker_container" "container" {
  name       = "${var.name}"
  image      = "${docker_image.image.latest}"
  ports      = "${var.ports}"
  restart    = "${var.restart}"
  env        = ["${var.env}"]
  command    = "${var.command}"
  entrypoint = "${var.entrypoint}"
  user       = "${var.user}"

  network_mode = "${var.network_mode}"

  capabilities = ["${var.capabilities}"]

  // Only attach the traefik network if
  // service is exposed to the web
  networks = ["${concat(var.networks,compact(split(",",lookup(var.web, "expose", "false") == "false" ? "" :"${data.docker_network.traefik.id}")))}"]

  networks_advanced = ["${var.networks_advanced}"]

  memory      = "${local.resource["memory"]}"
  memory_swap = "${local.resource["memory_swap"]}"

  volumes = ["${var.volumes}"]
  devices = ["${var.devices}"]

  dns = ["${var.dns}"]

  # Look at this monstrosity
  # And then https://github.com/hashicorp/terraform/issues/12453#issuecomment-365569618
  # for why this is needed

  labels = "${merge(local.default_labels,
    zipmap(
      concat(
        keys(local.default_labels),
        split("~",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join("~", keys(local.traefik_common_labels))
        )
      ),
      concat(
        values(local.default_labels),
        split("~",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join("~", values(local.traefik_common_labels))
        )
      )
    ),
    zipmap(
      concat(
        keys(local.default_labels),
        split("~",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join("~", keys(local.web))
        )
      ),
      concat(
        values(local.default_labels),
        split("~",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join("~", values(local.web))
        )
      )
    ),


    zipmap(
      concat(
        keys(local.default_labels),
        split("~",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join("~", keys(local.traefik_common_labels))
        )
      ),
      concat(
        values(local.default_labels),
        split("~",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join("~", values(local.traefik_common_labels))
        )
      )
    ),
    zipmap(
      concat(
        keys(local.default_labels),
        split("~",
          lookup(var.web, "auth", "false") == "false" ?
            "" :
            join("~", keys(local.traefik_auth_labels))
        )
      ),
      concat(
        values(local.default_labels),
        split("~",
          lookup(var.web, "auth", "false") == "false" ?
            "" :
            join("~", values(local.traefik_auth_labels))
        )
      )
    )
  )}"
  destroy_grace_seconds = "${var.destroy_grace_seconds}"
  must_run              = "${var.must_run}"
}

data "docker_registry_image" "image" {
  name = "${var.image}"
}

resource "docker_image" "image" {
  name          = "${data.docker_registry_image.image.name}"
  pull_triggers = ["${data.docker_registry_image.image.sha256_digest}"]
}

resource "docker_container" "container" {
  name       = "${var.name}"
  image      = "${docker_image.image.latest}"
  ports      = "${var.ports}"
  restart    = "${var.restart}"
  env        = "${var.env}"
  command    = "${var.command}"
  entrypoint = "${var.entrypoint}"
  user       = "${var.user}"
  networks   = ["${var.networks}"]

  # memory     = "${lookup(var.resource, "memory", "64")}"


  # Look at this monstrosity
  # And then https://github.com/hashicorp/terraform/issues/12453#issuecomment-365569618
  # for why this is needed

  labels = "${merge(local.default_labels,
    zipmap(
      concat(
        keys(local.traefik_common_labels),
        split(",",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join(",", keys(local.traefik_common_labels))
        )
      ),concat(
        values(local.traefik_common_labels),
        split(",",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join(",", values(local.traefik_common_labels))
        )
      )
    ),

    zipmap(
      concat(
        keys(local.web),
        split(",",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join(",", keys(local.web))
        )
      ),concat(
        values(local.web),
        split(",",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join(",", values(local.web))
        )
      )
    ),

    zipmap(
      concat(
        keys(local.traefik_common_labels),
        split(",",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join(",", keys(local.traefik_common_labels))
        )
      ),concat(
        values(local.traefik_common_labels),
        split(",",
          lookup(var.web, "expose", "false") == "false" ?
            "" :
            join(",", values(local.traefik_common_labels))
        )
      )
    ),
    zipmap(
      concat(
        keys(local.traefik_auth_labels),
        split(",",
          lookup(var.web, "auth", "false") == "false" ?
            "" :
            join(",", keys(local.traefik_auth_labels))
        )
      ),concat(
        values(local.traefik_auth_labels),
        split(",",
          lookup(var.web, "auth", "false") == "false" ?
            "" :
            join(",", values(local.traefik_auth_labels))
        )
      )
    )
  )}"
  destroy_grace_seconds = "${var.destroy_grace_seconds}"
  must_run              = "${var.must_run}"
}
